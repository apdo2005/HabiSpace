import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'package:habispace/core/error/app_exception.dart';
import '../../../../favorite/domain/entities/favorite_property_entity.dart';
import '../../../../favorite/domain/useCases/Add_to_favourite.dart';
import '../../../../favorite/domain/useCases/Get_list_favourite.dart';
import '../../../../favorite/domain/useCases/Remove_favourite.dart';
import 'favorite_cubit_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final GetListFavoriteUseCase getListFavoriteUseCase;
  final AddToFavouriteUseCase addToFavouriteUseCase;
  final RemoveFavouriteUseCase removeFavouriteUseCase;

  // Tracks IDs optimistically added — cleared only when getFavorites() refreshes
  final Set<int> _pendingAddIds = {};
  final Set<int> _confirmedAddIds = {};

  FavoriteCubit({
    required this.getListFavoriteUseCase,
    required this.addToFavouriteUseCase,
    required this.removeFavouriteUseCase,
  }) : super(FavoriteInitial());

  Future<void> getFavorites() async {
    emit(FavoriteLoading());
    try {
      final favorites = await getListFavoriteUseCase.call();
      // Real data from server — clear all optimistic tracking
      _pendingAddIds.clear();
      _confirmedAddIds.clear();
      emit(FavoriteLoaded(favorites));
    } catch (e, st) {
      debugPrint('❌ FavoriteCubit.getFavorites error: $e\n$st');
      emit(FavoriteError(handleException(e).message));
    }
  }

  // ── Add ───────────────────────────────────────────────────────────────────

  Future<void> addFavorite(int propertyId) async {
    final current = state;

    // Step 1: optimistic — show star as active immediately
    _pendingAddIds.add(propertyId);
    if (current is FavoriteLoaded) {
      emit(current.copyWith(
        pendingFavoriteIds: {..._pendingAddIds, ..._confirmedAddIds},
      ));
    }

    try {
      await addToFavouriteUseCase.call(propertyId);
      // Step 2: API confirmed — move to confirmed set, keep star active
      _pendingAddIds.remove(propertyId);
      _confirmedAddIds.add(propertyId);

      // Step 3: silently refresh favorites list — no FavoriteLoading emitted
      final favorites = await getListFavoriteUseCase.call();
      _pendingAddIds.clear();
      _confirmedAddIds.clear();
      final curr = state;
      emit(FavoriteLoaded(
        favorites,
        isEditMode: curr is FavoriteLoaded ? curr.isEditMode : false,
        searchQuery: curr is FavoriteLoaded ? curr.searchQuery : '',
      ));
    } catch (e) {
      // Rollback — remove from both sets
      _pendingAddIds.remove(propertyId);
      _confirmedAddIds.remove(propertyId);
      final curr = state;
      if (curr is FavoriteLoaded) {
        emit(curr.copyWith(
          pendingFavoriteIds: {..._pendingAddIds, ..._confirmedAddIds},
        ));
      }
      debugPrint('❌ FavoriteCubit.addFavorite error: $e');
    }
  }

  // ── Check ──────────────────────────────────────────────────────────────────

  bool isFavorite(int propertyId) {
    if (_pendingAddIds.contains(propertyId)) return true;
    final current = state;
    if (current is FavoriteLoaded) {
      return current.favorites.any((p) => p.id == propertyId);
    }
    return false;
  }

  // ── Search / filter ────────────────────────────────────────────────────────

  void search(String query) {
    final current = state;
    if (current is FavoriteLoaded) {
      emit(current.copyWith(searchQuery: query));
    }
  }

  // ── Edit mode toggle ───────────────────────────────────────────────────────

  void toggleEditMode() {
    final current = state;
    if (current is FavoriteLoaded) {
      emit(current.copyWith(isEditMode: !current.isEditMode));
    }
  }

  // ── Remove ─────────────────────────────────────────────────────────────────

  Future<void> removeFavorite(int propertyId) async {
    final current = state;
    if (current is! FavoriteLoaded) return;

    // Also remove from optimistic sets
    _pendingAddIds.remove(propertyId);
    _confirmedAddIds.remove(propertyId);

    final currentList = List<FavoritePropertyEntity>.from(current.favorites);
    final updated = currentList.where((p) => p.id != propertyId).toList();
    final wasEditMode = current.isEditMode;

    emit(FavoriteRemoving(
      currentList,
      propertyId,
      isEditMode: wasEditMode,
      searchQuery: current.searchQuery,
    ));

    try {
      await removeFavouriteUseCase.call(propertyId);
      emit(FavoriteLoaded(
        updated,
        isEditMode: wasEditMode,
        searchQuery: current.searchQuery,
      ));
    } catch (e) {
      emit(FavoriteLoaded(
        currentList,
        isEditMode: wasEditMode,
        searchQuery: current.searchQuery,
      ));
    }
  }
}

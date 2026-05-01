import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habispace/features/Favorite/Domain/Entities/PropertyEntity.dart';
import 'package:habispace/features/Favorite/Domain/Use%20Cases/Get_list_favourite.dart';
import 'package:habispace/features/Favorite/Domain/Use%20Cases/Remove_favourite.dart';
import 'package:habispace/features/Favorite/Presentation/Cubit/FavoriteCubit/favorite_cubit_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final GetListFavoriteUseCase getListFavoriteUseCase;
  final RemoveFavouriteUseCase removeFavouriteUseCase;

  FavoriteCubit({
    required this.getListFavoriteUseCase,
    required this.removeFavouriteUseCase,
  }) : super(FavoriteInitial());

  // ── Fetch ──────────────────────────────────────────────────────────────────

  Future<void> getFavorites() async {
    emit(FavoriteLoading());
    try {
      final favorites = await getListFavoriteUseCase.call();
      emit(FavoriteLoaded(favorites));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
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

    final currentList = List<PropertyEntity>.from(current.favorites);
    final updated = currentList.where((p) => p.id != propertyId).toList();

    emit(FavoriteRemoving(
      currentList,
      propertyId,
      isEditMode: true,
      searchQuery: current.searchQuery,
    ));

    try {
      await removeFavouriteUseCase.call(propertyId);
      emit(FavoriteLoaded(
        updated,
        isEditMode: true,
        searchQuery: current.searchQuery,
      ));
    } catch (e) {
      emit(FavoriteLoaded(
        currentList,
        isEditMode: true,
        searchQuery: current.searchQuery,
      ));
    }
  }
}

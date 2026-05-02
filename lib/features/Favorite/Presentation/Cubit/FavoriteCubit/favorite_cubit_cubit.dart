import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habispace/features/Favorite/Domain/Entities/PropertyEntity.dart';
import 'package:habispace/features/Favorite/Domain/Use%20Cases/Add_to_favourite.dart';
import 'package:habispace/features/Favorite/Domain/Use%20Cases/Get_list_favourite.dart';
import 'package:habispace/features/Favorite/Domain/Use%20Cases/Remove_favourite.dart';
import 'package:habispace/features/Favorite/Presentation/Cubit/FavoriteCubit/favorite_cubit_state.dart';
import 'package:habispace/shared/snakbar.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final GetListFavoriteUseCase getListFavoriteUseCase;
  final RemoveFavouriteUseCase removeFavouriteUseCase;
  final AddToFavouriteUseCase  addToFavouriteUseCase;
  FavoriteCubit({
    required this.getListFavoriteUseCase,
    required this.removeFavouriteUseCase,
    required this.addToFavouriteUseCase,
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
  // ── Add ────────────────────────────────────────────────────────────────────
   Future<void> toggleFavorite(PropertyEntity property)async{
    final current=state;
    if(current is! FavoriteLoaded) return;
    final List<PropertyEntity> currentList = List.from(current.favorites);
    final isExist=currentList.any((element) => element.id==property.id);
    try{
      if(isExist){
      final  updated=currentList.where((element) => element.id!=property.id).toList();
      emit(current.copyWith(favorites: updated));
      await removeFavouriteUseCase.call(property.id);
      
    }else{
      final updated=List<PropertyEntity>.from(current.favorites)..add(property);
      
      emit(current.copyWith(favorites: updated));
      await addToFavouriteUseCase.execute(property.id);
    }
    }
    catch(e){
          emit(current.copyWith(favorites: currentList));
     }
   }
   bool  isFavorite(int propertyId) {
    final current = state;
    if (current is FavoriteLoaded) {
      return current.favorites.any((property) => property.id == propertyId);
    }
    return false;
  }
}

import 'package:habispace/features/Favorite/Domain/Entities/PropertyEntity.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<PropertyEntity> favorites;
  final bool isEditMode;
  final String searchQuery;

  FavoriteLoaded(
    this.favorites, {
    this.isEditMode = false,
    this.searchQuery = '',
  });

  /// Returns favorites filtered by the current search query.
  List<PropertyEntity> get filtered {
    if (searchQuery.trim().isEmpty) return favorites;
    final q = searchQuery.toLowerCase();
    return favorites.where((p) {
      return p.title.toLowerCase().contains(q) ||
          p.categoryName.toLowerCase().contains(q) ||
          p.address.toLowerCase().contains(q);
    }).toList();
  }

  FavoriteLoaded copyWith({
    List<PropertyEntity>? favorites,
    bool? isEditMode,
    String? searchQuery,
  }) {
    return FavoriteLoaded(
      favorites ?? this.favorites,
      isEditMode: isEditMode ?? this.isEditMode,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class FavoriteError extends FavoriteState {
  final String message;
  FavoriteError(this.message);
}

class FavoriteRemoving extends FavoriteState {
  final List<PropertyEntity> favorites;
  final int removingId;
  final bool isEditMode;
  final String searchQuery;

  FavoriteRemoving(
    this.favorites,
    this.removingId, {
    this.isEditMode = true,
    this.searchQuery = '',
  });

  List<PropertyEntity> get filtered {
    if (searchQuery.trim().isEmpty) return favorites;
    final q = searchQuery.toLowerCase();
    return favorites.where((p) {
      return p.title.toLowerCase().contains(q) ||
          p.categoryName.toLowerCase().contains(q) ||
          p.address.toLowerCase().contains(q);
    }).toList();
  }
}

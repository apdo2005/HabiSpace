import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habispace/features/Favorite/Domain/Entities/PropertyEntity.dart';
import 'package:habispace/features/Favorite/Presentation/Cubit/FavoriteCubit/favorite_cubit_cubit.dart';
import 'package:habispace/features/Favorite/Presentation/Cubit/FavoriteCubit/favorite_cubit_state.dart';
import 'package:habispace/features/Favorite/Presentation/Pages/favorite_details_page.dart';
import 'package:habispace/features/Favorite/Presentation/Widgets/favorite_card_widget.dart';
import 'package:habispace/features/Favorite/Presentation/Widgets/favorite_header_widget.dart';

class FavoriteBody extends StatelessWidget {
  final String? categoryFilter;
  final List<PropertyEntity>? allFavorites;

  const FavoriteBody({
    super.key,
    this.categoryFilter,
    this.allFavorites,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F2),
      body: SafeArea(
        child: BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            switch (state) {
              case FavoriteLoading():
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xFF2BBFB3)),
                );
              case FavoriteError(:final message):
                return _ErrorView(
                  message: message,
                  onRetry: () => context.read<FavoriteCubit>().getFavorites(),
                );
              case FavoriteLoaded():
                return _FavoriteList(
                  favorites: state.filtered,
                  categoryFilter: categoryFilter,
                  isEditMode: state.isEditMode,
                  removingId: null,
                );
              case FavoriteRemoving():
                return _FavoriteList(
                  favorites: state.filtered,
                  categoryFilter: categoryFilter,
                  isEditMode: state.isEditMode,
                  removingId: state.removingId,
                );
              default:
                if (allFavorites != null) {
                  final filtered = categoryFilter != null
                      ? allFavorites!
                          .where((p) => p.categoryName == categoryFilter)
                          .toList()
                      : allFavorites!;
                  return _FavoriteList(
                    favorites: filtered,
                    categoryFilter: categoryFilter,
                    isEditMode: false,
                    removingId: null,
                  );
                }
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

// ── Favorites list ────────────────────────────────────────────────────────────

class _FavoriteList extends StatelessWidget {
  final List<PropertyEntity> favorites;
  final String? categoryFilter;
  final bool isEditMode;
  final int? removingId;

  const _FavoriteList({
    required this.favorites,
    this.categoryFilter,
    required this.isEditMode,
    required this.removingId,
  });

  @override
  Widget build(BuildContext context) {
    final displayed = categoryFilter != null
        ? favorites.where((p) => p.categoryName == categoryFilter).toList()
        : favorites;

    return Column(
      children: [
        FavoriteHeaderWidget(
          title: categoryFilter ?? 'Your Favorite',
          isEditMode: isEditMode,
          onEdit: () => context.read<FavoriteCubit>().toggleEditMode(),
        ),
        Expanded(
          child: displayed.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.search_off, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text(
                        isEditMode ? 'No favorites yet' : 'No results found',
                        style: const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  itemCount: displayed.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final property = displayed[index];
                    final isRemoving = removingId == property.id;

                    return _EditableCard(
                      property: property,
                      isEditMode: isEditMode,
                      isRemoving: isRemoving,
                      allFavorites: favorites,
                    );
                  },
                ),
        ),
      ],
    );
  }
}

// ── Card with optional remove badge ──────────────────────────────────────────

class _EditableCard extends StatelessWidget {
  final PropertyEntity property;
  final bool isEditMode;
  final bool isRemoving;
  final List<PropertyEntity> allFavorites;

  const _EditableCard({
    required this.property,
    required this.isEditMode,
    required this.isRemoving,
    required this.allFavorites,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Dim card while removing
        AnimatedOpacity(
          opacity: isRemoving ? 0.4 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: FavoriteCardWidget(
            property: property,
            onTap: isEditMode
                ? null
                : () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FavoriteDetailsPage(
                          property: property,
                          allFavorites: allFavorites,
                        ),
                      ),
                    ),
            onFavoriteTap: () {},
          ),
        ),

        // Remove badge — top-left corner, only in edit mode
        if (isEditMode)
          Positioned(
            top: -8,
            left: -8,
            child: GestureDetector(
              onTap: isRemoving
                  ? null
                  : () =>
                      context.read<FavoriteCubit>().removeFavorite(property.id),
              child: Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: isRemoving
                    ? const Padding(
                        padding: EdgeInsets.all(6),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.remove, color: Colors.white, size: 18),
              ),
            ),
          ),
      ],
    );
  }
}

// ── Error view ────────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2BBFB3),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Empty view ────────────────────────────────────────────────────────────────

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No favorites yet',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

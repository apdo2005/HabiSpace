import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habispace/features/Favorite/Domain/Entities/PropertyEntity.dart';
import 'package:habispace/features/Favorite/Presentation/Cubit/FavoriteCubit/favorite_cubit_cubit.dart';
import 'package:habispace/features/Favorite/Presentation/Cubit/FavoriteCubit/favorite_cubit_state.dart';
import 'package:habispace/features/Favorite/Presentation/Pages/favoriteMainPage.dart';
import 'package:habispace/features/Favorite/Presentation/Widgets/property_image_widget.dart';

/// Groups all favorites by categoryName and shows them as a grid.
class FavoriteCategoriesPage extends StatelessWidget {
  const FavoriteCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F2),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            if (state is FavoriteLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF2BBFB3)),
              );
            }
            if (state is FavoriteError) {
              return _ErrorView(
                message: state.message,
                onRetry: () => context.read<FavoriteCubit>().getFavorites(),
              );
            }
            if (state is FavoriteLoaded) {
              if (state.favorites.isEmpty) return const _EmptyView();
              // filtered is empty but favorites exist → no search results
              if (state.filtered.isEmpty) {
                return const _NoResultsView();
              }
              return _CategoriesContent(
                favorites: state.filtered,
                allFavorites: state.favorites,
              );
            }
            return const SizedBox.shrink();
          },
        ),
    );
  }
}

// ── Content ───────────────────────────────────────────────────────────────────

class _CategoriesContent extends StatelessWidget {
  final List<PropertyEntity> favorites;       // filtered list for display
  final List<PropertyEntity> allFavorites;    // full list for navigation

  const _CategoriesContent({
    required this.favorites,
    required this.allFavorites,
  });

  /// Groups properties by categoryName → { name: [properties] }
  Map<String, List<PropertyEntity>> _groupByCategory() {
    final map = <String, List<PropertyEntity>>{};
    for (final p in favorites) {
      map.putIfAbsent(p.categoryName, () => []).add(p);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _groupByCategory();
    final categories = grouped.entries.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _PageHeader(),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 14,
              mainAxisSpacing: 14,
              childAspectRatio: 0.85,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final name = categories[index].key;
              final properties = categories[index].value;
              return _CategoryCard(
                categoryName: name,
                properties: properties,
                allFavorites: allFavorites,
              );
            },
          ),
        ),
      ],
    );
  }
}

// ── Page header ───────────────────────────────────────────────────────────────

class _PageHeader extends StatelessWidget {
  const _PageHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Your Favorite',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          // TextButton(
          //   onPressed: () {},
          //   child: const Text(
          //     'Edit',
          //     style: TextStyle(
          //       fontSize: 15,
          //       fontWeight: FontWeight.w600,
          //       color: Color(0xFF2BBFB3),
          //       decoration: TextDecoration.underline,
          //       decorationColor: Color(0xFF2BBFB3),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

// ── Category card ─────────────────────────────────────────────────────────────

class _CategoryCard extends StatelessWidget {
  final String categoryName;
  final List<PropertyEntity> properties;
  final List<PropertyEntity> allFavorites;

  const _CategoryCard({
    required this.categoryName,
    required this.properties,
    required this.allFavorites,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: context.read<FavoriteCubit>(),
            child: FavoriteBody(
              categoryFilter: categoryName,
              allFavorites: allFavorites,
            ),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 2×2 image grid
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: _ImageGrid(properties: properties),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            categoryName,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            '${properties.length} ${properties.length == 1 ? 'property' : 'properties'}',
            style: const TextStyle(fontSize: 12, color: Colors.black45),
          ),
        ],
      ),
    );
  }
}

// ── 2×2 image grid ────────────────────────────────────────────────────────────

class _ImageGrid extends StatelessWidget {
  final List<PropertyEntity> properties;
  const _ImageGrid({required this.properties});

  /// Collect up to 4 image URLs from the properties
  List<String?> _slots() {
    final urls = <String?>[];
    for (final p in properties) {
      for (final img in p.images) {
        urls.add(img);
        if (urls.length == 4) return urls;
      }
    }
    while (urls.length < 4) {
      urls.add(null);
    }
    return urls;
  }

  @override
  Widget build(BuildContext context) {
    final slots = _slots();

    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(child: _Tile(url: slots[0])),
              const SizedBox(width: 2),
              Expanded(child: _Tile(url: slots[1])),
            ],
          ),
        ),
        const SizedBox(height: 2),
        Expanded(
          child: Row(
            children: [
              Expanded(child: _Tile(url: slots[2])),
              const SizedBox(width: 2),
              Expanded(child: _Tile(url: slots[3])),
            ],
          ),
        ),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  final String? url;
  const _Tile({this.url});

  @override
  Widget build(BuildContext context) {
    return PropertyImageWidget(
      imageUrl: url,
      borderRadius: BorderRadius.zero,
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

// ── No results view ───────────────────────────────────────────────────────────

class _NoResultsView extends StatelessWidget {
  const _NoResultsView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No results found',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

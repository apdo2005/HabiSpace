import 'package:flutter/material.dart';
import 'package:habispace/features/Favorite/Domain/Entities/PropertyEntity.dart';
import 'package:habispace/features/Favorite/Presentation/Widgets/amenity_chip_widget.dart';
import 'package:habispace/features/Favorite/Presentation/Widgets/favorite_card_widget.dart';
import 'package:habispace/features/Favorite/Presentation/Widgets/property_image_widget.dart';
import 'package:habispace/features/Favorite/Presentation/Widgets/type_badge_widget.dart';

class FavoriteDetailsPage extends StatelessWidget {
  final PropertyEntity property;
  final List<PropertyEntity> allFavorites;

  const FavoriteDetailsPage({
    super.key,
    required this.property,
    this.allFavorites = const [],
  });

  List<PropertyEntity> get _relatedProperties => allFavorites
      .where((p) => p.categoryId == property.categoryId && p.id != property.id)
      .toList();

  @override
  Widget build(BuildContext context) {
    final related = _relatedProperties;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F2),
      // Stack: scroll content behind a floating back button
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _DetailsSliverAppBar(property: property),
              SliverToBoxAdapter(
                child: _DetailsContent(property: property),
              ),
              if (related.isNotEmpty) ...[
                const SliverToBoxAdapter(child: _RelatedHeader()),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                  sliver: SliverList.separated(
                    itemCount: related.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) => FavoriteCardWidget(
                      property: related[index],
                      onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FavoriteDetailsPage(
                            property: related[index],
                            allFavorites: allFavorites,
                          ),
                        ),
                      ),
                      onFavoriteTap: () {},
                    ),
                  ),
                ),
              ],
            ],
          ),

          // Floating back button — always visible, always tappable
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: _FloatingBackButton(),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Floating back button ──────────────────────────────────────────────────────

class _FloatingBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
      ),
    );
  }
}

// ── Sliver app bar with hero image ────────────────────────────────────────────

class _DetailsSliverAppBar extends StatelessWidget {
  final PropertyEntity property;
  const _DetailsSliverAppBar({required this.property});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      // Hide the default leading — we use our own floating button
      automaticallyImplyLeading: false,
      leading: const SizedBox.shrink(),
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            PropertyImageWidget(
              imageUrl:
                  property.images.isNotEmpty ? property.images.first : null,
            ),
            // Dark gradient at top so back button stays readable when collapsed
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                  colors: [Colors.black38, Colors.transparent],
                ),
              ),
            ),
            Positioned(
              top: 60,
              left: 16,
              child: TypeBadgeWidget(label: property.type),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Main content card ─────────────────────────────────────────────────────────

class _DetailsContent extends StatelessWidget {
  final PropertyEntity property;
  const _DetailsContent({required this.property});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DetailsTitleRow(property: property),
          const SizedBox(height: 10),
          _DetailsLocationRow(property: property),
          const SizedBox(height: 16),
          AmenitiesWrap(property: property),
          const SizedBox(height: 20),
          _DetailsPriceRow(property: property),
        ],
      ),
    );
  }
}

// ── Title + favorite star ─────────────────────────────────────────────────────

class _DetailsTitleRow extends StatelessWidget {
  final PropertyEntity property;
  const _DetailsTitleRow({required this.property});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            property.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.star, color: Color(0xFFFFC107), size: 28),
      ],
    );
  }
}

// ── Location + distance ───────────────────────────────────────────────────────

class _DetailsLocationRow extends StatelessWidget {
  final PropertyEntity property;
  const _DetailsLocationRow({required this.property});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.location_on_outlined,
            size: 16, color: Color(0xFF2BBFB3)),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            property.address,
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ),
        if (property.distance.isNotEmpty) ...[
          const SizedBox(width: 8),
          Container(width: 1, height: 14, color: Colors.black26),
          const SizedBox(width: 8),
          const Icon(Icons.near_me_outlined,
              size: 15, color: Color(0xFF2BBFB3)),
          const SizedBox(width: 4),
          Text(
            property.distance,
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ],
      ],
    );
  }
}

// ── Price + rating ────────────────────────────────────────────────────────────

class _DetailsPriceRow extends StatelessWidget {
  final PropertyEntity property;
  const _DetailsPriceRow({required this.property});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '\$${property.price}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const TextSpan(
                text: '/ month',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
        if (property.rating > 0)
          Row(
            children: [
              const Icon(Icons.star, color: Color(0xFFFFC107), size: 20),
              const SizedBox(width: 4),
              Text(
                property.rating.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
      ],
    );
  }
}

// ── Related properties header ─────────────────────────────────────────────────

class _RelatedHeader extends StatelessWidget {
  const _RelatedHeader();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Text(
        'More in this category',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}

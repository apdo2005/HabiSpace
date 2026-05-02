import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habispace/core/constants/images_pathes.dart';
import 'package:habispace/features/Favorite/Domain/Entities/PropertyEntity.dart' as FavEntity;
import 'package:habispace/features/Favorite/Presentation/Cubit/FavoriteCubit/favorite_cubit_cubit.dart';
import 'package:habispace/features/Favorite/Presentation/Cubit/FavoriteCubit/favorite_cubit_state.dart';
import 'package:habispace/shared/custom_svg_image.dart';
import 'package:habispace/utils/app_color.dart';
import 'package:habispace/utils/app_sizes.dart';
import '../../domain/entity/property_entity.dart';

class PropertyCard extends StatelessWidget {
  final PropertyEntity property;

  const PropertyCard({required this.property});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.w220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: property.images.isNotEmpty
                    ? SizedBox(
                  height: AppSizes.h140,
                  width: AppSizes.w220,
                  child: Image.network(
                    property.images[0],
                    fit: BoxFit.cover,
                    loadingBuilder: (_, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey.shade200,
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    },
                    errorBuilder: (_, __, ___) => SizedBox(
                      height: AppSizes.h140,
                      width: AppSizes.w220,
                      child: SvgPicture.asset(
                        ImagesPathes.test,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
                    : CustomSvgImage(
                  path: ImagesPathes.vella,
                  height: AppSizes.h140,
                  width: AppSizes.w220,
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.w8,
                    vertical: AppSizes.h6,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        property.listingType == 'sale'
                            ? ImagesPathes.sale
                            : ImagesPathes.sale,
                        height: AppSizes.h16,
                        width: AppSizes.w16,
                      ),
                      SizedBox(width: AppSizes.w4),
                      Text(
                        property.listingType == 'sale'
                            ? 'For Sale'
                            : 'For Rent',
                        style: TextStyle(
                          fontSize: AppSizes.sp12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.w12,
              vertical: AppSizes.h10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + Favorite
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        property.title,
                        style: TextStyle(
                          fontSize: AppSizes.sp16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        try {
                          // Convert PropertyEntity to FavEntity.PropertyEntity
                          final favProperty = FavEntity.PropertyEntity(
                            id: property.id,
                            title: property.title,
                            price: property.price.toString(),
                            address: property.address,
                            categoryId: property.category.id,
                            categoryName: property.category.name,
                            images: property.images,
                            bedrooms: property.bedrooms,
                            bathrooms: property.bathrooms,
                            rating: 0.0,
                            type: property.listingType,
                            amenities: [],
                            distance: '',
                          );
                          context.read<FavoriteCubit>().toggleFavorite(favProperty);
                        } catch (e) {
                          // FavoriteCubit not available in this context
                        }
                      },
                      child: BlocBuilder<FavoriteCubit, FavoriteState>(
                        builder: (context, state) {
                          bool isFavorite = false;
                          if (state is FavoriteLoaded) {
                            isFavorite = state.favorites.any((p) => p.id == property.id);
                          }
                          return Icon(
                            isFavorite ? Icons.star : Icons.star_border,
                            size: AppSizes.h24,
                            color: isFavorite ? Colors.amber : AppColors.black,
                          );
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: AppSizes.h6),

                // Address
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: AppSizes.h14,
                      color: AppColors.blue,
                    ),
                    SizedBox(width: AppSizes.w2),
                    Expanded(
                      child: Text(
                        property.address,
                        style: TextStyle(
                          fontSize: AppSizes.sp12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: AppSizes.h8),

                // Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${property.price.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: AppSizes.sp18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                    // Rating — not in API yet, hardcoded for now
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: AppSizes.h16,
                          color: Colors.amber,
                        ),
                        SizedBox(width: AppSizes.w2),
                        Text(
                          '4.9',
                          style: TextStyle(
                            fontSize: AppSizes.sp12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
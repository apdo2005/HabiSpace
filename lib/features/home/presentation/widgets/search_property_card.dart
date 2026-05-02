import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habispace/shared/custom_svg_image.dart';
import 'package:habispace/core/constants/images_pathes.dart';
import 'package:habispace/utils/app_color.dart';
import 'package:habispace/utils/app_sizes.dart';
import '../../domain/entity/property_entity.dart';

class SearchPropertyCard extends StatelessWidget {
  final PropertyEntity property;

  const SearchPropertyCard({required this.property});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.light,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.07),
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
               property.images.isNotEmpty
                  ? SizedBox(
                height: AppSizes.h140,
                width: AppSizes.w370,
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
                    width: AppSizes.w370,
                    child: SvgPicture.asset(
                      ImagesPathes.test,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
                  : Image.asset(
                ImagesPathes.vella,
                fit: BoxFit.cover,
                height: AppSizes.h140,
                width: AppSizes.w220,
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
                    color: AppColors.light,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                     CustomSvgImage(
                      path:  property.listingType == 'sale'
                           ? ImagesPathes.sale
                           : ImagesPathes.sale,
                       height: AppSizes.h16,
                       width: AppSizes.w16,
                     )
                      ,
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
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.star_border,
                        size: AppSizes.h24,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: AppSizes.h6),

                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: AppSizes.h14,
                      color: AppColors.blue,
                    ),
                    SizedBox(width: AppSizes.w2),
                    Text(
                      property.address,
                      style: TextStyle(
                        fontSize: AppSizes.sp12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: AppSizes.h8),

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
                    Row(
                      children: [
                        Icon(Icons.star,
                            size: AppSizes.h16, color: Colors.amber),
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
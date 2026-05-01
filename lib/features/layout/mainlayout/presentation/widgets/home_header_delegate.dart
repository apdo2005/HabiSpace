import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habispace/core/constants/images_pathes.dart';
import 'package:habispace/utils/app_color.dart';
import 'package:habispace/utils/app_sizes.dart';
import 'header_icon_button.dart';

class HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TextEditingController searchController;
  final ValueChanged<String> onSearch;

  HomeHeaderDelegate({
    required this.searchController,
    required this.onSearch,
  });

  @override
  double get minExtent => 80;

  @override
  double get maxExtent => 80;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: 80,
      color: AppColors.lightGrayColor,
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.w16,
        vertical: AppSizes.h12,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: Center(
                child: TextField(
                  controller: searchController,
                  onChanged: onSearch,
                  cursorHeight: 15,
                  cursorWidth: 2,
                  cursorColor: AppColors.blue,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    border: InputBorder.none,
                    hintText: 'Search your home',
                    hintStyle: TextStyle(
                      color: AppColors.textSecondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: Icon(
                      CupertinoIcons.search,
                      color: AppColors.textSecondaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: AppSizes.w12),
          HeaderIconButton(
            path: ImagesPathes.filter,
            onTap: () {
              // TODO: show filter bottom sheet
            },
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant HomeHeaderDelegate oldDelegate) =>
      oldDelegate.searchController != searchController;
}

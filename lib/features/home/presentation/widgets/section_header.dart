import 'package:flutter/material.dart';
import 'package:habispace/utils/app_color.dart';
import 'package:habispace/utils/app_sizes.dart';
import 'package:habispace/utils/app_texts.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.onViewAll,
  });

  final String title;
  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.w16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: AppSizes.sp20,
                fontWeight: FontWeight.w700,
              ),
            ),
            GestureDetector(
              onTap: onViewAll,
              child: Text(
                AppTexts.viewAll,
                style: TextStyle(
                  fontSize: AppSizes.sp14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habispace/utils/app_color.dart';

class HeaderIconButton extends StatelessWidget {
  const HeaderIconButton({
    super.key,
    required this.path,
    required this.onTap,
    this.width = 20,
    this.height = 20,
    this.color = AppColors.lightsmall,
  });

  final String path;
  final VoidCallback onTap;
  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(28),
        ),
        child: SvgPicture.asset(
          path,
          width: width,
          height: height,
          colorFilter: const ColorFilter.mode(
            AppColors.secondaryColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

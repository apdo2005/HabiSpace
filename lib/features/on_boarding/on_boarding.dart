import 'package:flutter/material.dart';
import 'package:habispace/shared/custom_svg.dart';
import 'package:habispace/utils/app_sizes.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomSvgImage(
            path: 'assets/images/on_boarding_image.svg',
            width: AppSizes.w200,
            height: AppSizes.h200,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
} 

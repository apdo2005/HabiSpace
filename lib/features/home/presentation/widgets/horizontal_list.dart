import 'package:flutter/material.dart';
import 'package:habispace/utils/app_sizes.dart';

class HorizontalList extends StatelessWidget {
  const HorizontalList({super.key,
    required this.items,
    required this.builder,
  });
  final List items;
  final Widget Function(int index) builder;
  @override
  Widget build(BuildContext context) {

    return  SliverToBoxAdapter(
      child: SizedBox(
        height: AppSizes.h260,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          padding: EdgeInsets.symmetric(horizontal: AppSizes.w16),
          separatorBuilder: (_, __) => SizedBox(width: AppSizes.w12),
          itemBuilder: (context, index) => builder(index),
        ),
      ),
    );
  }
}

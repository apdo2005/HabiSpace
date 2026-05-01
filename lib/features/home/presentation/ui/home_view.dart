import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habispace/features/home/presentation/pages/all_properties_page.dart';
import 'package:habispace/utils/app_sizes.dart';
import 'package:habispace/utils/app_texts.dart';
import '../widgets/filter_chip_item.dart';
import '../cubit/home_cubit.dart';
import '../widgets/horizontal_list.dart';
import '../widgets/property_card.dart';
import '../widgets/search_property_card.dart';
import '../widgets/section_header.dart';

List<Widget> homeViewSlivers(BuildContext context, HomeState state) {

  if (state is HomeSearchSuccess) {
    return [
      if (state.results.isEmpty)
        SliverFillRemaining(
          child: Center(
            child: Text(
              'No results for "${state.query}"',
              style: TextStyle(
                fontSize: AppSizes.sp16,
                color: Colors.grey,
              ),
            ),
          ),
        )
      else
        SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.w16,
            vertical: AppSizes.h12,
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                padding: EdgeInsets.only(bottom: AppSizes.h12),
                child: SearchPropertyCard(
                  property: state.results[index],
                ),
              ),
              childCount: state.results.length,
            ),
          ),
        ),
    ];
  }


  if (state is HomeLoading) {
    return [
      const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      ),
    ];
  }

  if (state is HomeError) {
    return [
      SliverFillRemaining(
        child: Center(child: Text(state.message)),
      ),
    ];
  }

  if (state is HomeSuccess) {
    final tabs = ['All', ...state.home.categories.map((c) => c.name)];

    return [
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.w16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                tabs.length,
                    (index) => FilterChipItem(
                  text: tabs[index],
                  isSelected: state.selectedTab == index,
                  onTap: () =>
                      context.read<HomeCubit>().filterByCategory(index),
                ),
              ),
            ),
          ),
        ),
      ),

      SliverToBoxAdapter(child: SizedBox(height: AppSizes.h16)),

      if (state.filteredBestSelling.isNotEmpty) ...[
        SectionHeader(
          title: AppTexts.bestOffers,
          onViewAll: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AllPropertiesPage(
                title: AppTexts.bestOffers,
                properties: state.filteredBestSelling,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: AppSizes.h12)),
        HorizontalList(
          items: state.filteredBestSelling,
          builder: (index) =>
              PropertyCard(property: state.filteredBestSelling[index]),
        ),
        SliverToBoxAdapter(child: SizedBox(height: AppSizes.h16)),
      ],

      if (state.filteredFeatured.isNotEmpty) ...[
        SectionHeader(
          title: AppTexts.featured,
          onViewAll: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AllPropertiesPage(
                title: AppTexts.featured,
                properties: state.filteredFeatured,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: AppSizes.h12)),
        HorizontalList(
          items: state.filteredFeatured,
          builder: (index) =>
              PropertyCard(property: state.filteredFeatured[index]),
        ),
        SliverToBoxAdapter(child: SizedBox(height: AppSizes.h16)),
      ],

      if (state.filteredRecommended.isNotEmpty) ...[
        SectionHeader(
          title: AppTexts.recommended,
          onViewAll: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AllPropertiesPage(
                title: AppTexts.recommended,
                properties: state.filteredRecommended,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: AppSizes.h12)),
        HorizontalList(
          items: state.filteredRecommended,
          builder: (index) =>
              PropertyCard(property: state.filteredRecommended[index]),
        ),
        SliverToBoxAdapter(child: SizedBox(height: AppSizes.h16)),
      ],

      if (state.filteredBestSelling.isEmpty &&
          state.filteredFeatured.isEmpty &&
          state.filteredRecommended.isEmpty)
        SliverFillRemaining(
          child: Center(
            child: Text(
              'No properties found',
              style: TextStyle(
                fontSize: AppSizes.sp16,
                color: Colors.grey,
              ),
            ),
          ),
        ),

      SliverToBoxAdapter(child: SizedBox(height: AppSizes.h24)),
    ];
  }

  return [const SliverToBoxAdapter(child: SizedBox())];
}
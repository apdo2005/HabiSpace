import 'package:flutter/material.dart';
import 'package:habispace/features/home/domain/entity/property_entity.dart';
import 'package:habispace/features/home/presentation/widgets/search_property_card.dart';
import 'package:habispace/utils/app_color.dart';
import 'package:habispace/utils/app_sizes.dart';

class AllPropertiesPage extends StatelessWidget {
  final String title;
  final List<PropertyEntity> properties;

  const AllPropertiesPage({
    super.key,
    required this.title,
    required this.properties,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: AppSizes.sp18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: properties.isEmpty
          ? Center(
              child: Text(
                'No properties found',
                style: TextStyle(
                  fontSize: AppSizes.sp16,
                  color: Colors.grey,
                ),
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.w16,
                vertical: AppSizes.h16,
              ),
              itemCount: properties.length,
              separatorBuilder: (_, __) => SizedBox(height: AppSizes.h12),
              itemBuilder: (context, index) => SearchPropertyCard(
                property: properties[index],
              ),
            ),
    );
  }
}

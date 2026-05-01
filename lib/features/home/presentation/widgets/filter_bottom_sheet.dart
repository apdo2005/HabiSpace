import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habispace/utils/app_color.dart';
import 'package:habispace/utils/app_sizes.dart';
import '../../domain/entity/filter_entity.dart';
import '../cubit/home_cubit.dart';

class FilterBottomSheet extends StatefulWidget {
  final FilterEntity initialFilter;
  const FilterBottomSheet({super.key, required this.initialFilter});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? _selectedType;
  double _radius = 50;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.initialFilter.listingType;
    _radius = widget.initialFilter.radiusKm ?? 50;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSizes.w16, AppSizes.h24, AppSizes.w16, AppSizes.h32,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          SizedBox(height: AppSizes.h16),

          const Text('Filter', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: AppSizes.h24),

          const Text('Listing Type', style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(height: AppSizes.h12),
          Row(
            children: [
              _TypeChip(label: 'All',  value: null,     selected: _selectedType, onTap: (v) => setState(() => _selectedType = v)),
              SizedBox(width: AppSizes.w8),
              _TypeChip(label: 'Sale', value: 'sale',   selected: _selectedType, onTap: (v) => setState(() => _selectedType = v)),
              SizedBox(width: AppSizes.w8),
              _TypeChip(label: 'Rent', value: 'rent',   selected: _selectedType, onTap: (v) => setState(() => _selectedType = v)),
            ],
          ),
          SizedBox(height: AppSizes.h24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Radius', style: TextStyle(fontWeight: FontWeight.w600)),
              Text('${_radius.toInt()} km', style: TextStyle(color: AppColors.blue)),
            ],
          ),
          Slider(
            value: _radius,
            min: 5, max: 200, divisions: 39,
            activeColor: AppColors.blue,
            onChanged: (v) => setState(() => _radius = v),
          ),
          SizedBox(height: AppSizes.h24),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.blue),
                  ),
                  onPressed: () {
                    context.read<HomeCubit>().clearFilter();
                    Navigator.pop(context);
                  },
                  child: const Text('Clear', style: TextStyle(color: AppColors.blue)),
                ),
              ),
              SizedBox(width: AppSizes.w12),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.blue),
                  onPressed: () {
                    context.read<HomeCubit>().applyFilter(
                      FilterEntity(
                        listingType: _selectedType,
                        radiusKm: _radius,
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Apply', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TypeChip extends StatelessWidget {
  final String label;
  final String? value;
  final String? selected;
  final ValueChanged<String?> onTap;

  const _TypeChip({required this.label, required this.value, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isSelected = selected == value;
    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.blue : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
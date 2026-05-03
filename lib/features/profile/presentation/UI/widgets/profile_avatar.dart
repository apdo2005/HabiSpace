import 'package:flutter/material.dart';
import '../../../../../core/utils/app_color.dart';

class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final double radius;
  final bool isActive;
  final bool showBorder;

  const ProfileAvatar({
    super.key,
    this.imageUrl,
    required this.name,
    this.radius = 14,
    this.isActive = false,
    this.showBorder = false,
  });

  String get _initial =>
      name.isNotEmpty ? name[0].toUpperCase() : 'P';

  @override
  Widget build(BuildContext context) {
    final borderColor = isActive ? AppColors.blue : Colors.grey;

    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? AppColors.blue : Colors.grey.shade300,
        border: showBorder
            ? Border.all(color: borderColor, width: 2)
            : null,
      ),
      child: ClipOval(

        child: imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildInitial(),
              )
            : Image.network('https://i.pinimg.com/736x/1d/a5/22/1da522be47c880e198dc87f77133d649.jpg',
                fit: BoxFit.cover
        ),
      ),
    );
  }

  Widget _buildInitial() {
    return Center(
      child: Text(
        _initial,
        style: TextStyle(
          fontSize: radius * 0.85,
          fontWeight: FontWeight.bold,
          color: isActive ? Colors.white : Colors.grey.shade600,
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';

import '../../domain/entities/favorite_property_entity.dart';

class DetailsTitleRow extends StatelessWidget {
  final FavoritePropertyEntity property;
  const DetailsTitleRow({required this.property});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            property.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.star, color: Color(0xFFFFC107), size: 28),
      ],
    );
  }
}

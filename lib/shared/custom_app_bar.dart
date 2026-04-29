import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final VoidCallback? onSearch;
  final VoidCallback? onCart;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.onSearch,
    this.onCart,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 0,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),

      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: onBack ?? () => Navigator.pop(context),
      ),

      actions: [
        IconButton(icon: const Icon(Icons.search), onPressed: onSearch),
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined),
          onPressed: onCart,
        ),
      ],
    );
  }
}

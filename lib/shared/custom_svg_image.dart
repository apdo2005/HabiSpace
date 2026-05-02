import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:habispace/core/constants/images_pathes.dart';

class CustomSvgImage extends StatelessWidget {
  const CustomSvgImage({
    super.key,
    required this.path,
    this.height,
    this.width,
    this.fit,
    this.color,
    this.isNetwork = false,
  });

  final String path;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;
  final bool isNetwork;

  bool get _isNetworkUrl =>
      isNetwork || path.startsWith('http://') || path.startsWith('https://');

  @override
  Widget build(BuildContext context) {
    final colorFilter = color != null
        ? ColorFilter.mode(color!, BlendMode.srcIn)
        : null;

    Widget svgWidget;

    if (_isNetworkUrl) {
      // Network URL — use Image.network (handles PNG/JPG/etc.)
      svgWidget = Image.network(
        path,
        fit: fit ?? BoxFit.cover,
        width: width,
        height: height,
        loadingBuilder: (_, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: width,
            height: height,
            color: Colors.grey[200],
            child: const Center(child: CircularProgressIndicator()),
          );
        },
        errorBuilder: (_, __, ___) => SvgPicture.asset(
          ImagesPathes.test,
          fit: fit ?? BoxFit.cover,
          width: width,
          height: height,
        ),
      );
    } else {
      // Local asset — use SvgPicture.asset
      svgWidget = SvgPicture.asset(
        path,
        fit: fit ?? BoxFit.contain,
        colorFilter: colorFilter,
      );
    }

    if (height != null || width != null) {
      return SizedBox(height: height, width: width, child: svgWidget);
    }

    return svgWidget;
  }
}

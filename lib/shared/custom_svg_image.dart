import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

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

    final Widget svgWidget = _isNetworkUrl
        ? SvgPicture.network(
            path,
            fit: fit ?? BoxFit.contain,
            colorFilter: colorFilter,
            placeholderBuilder: (_) => Container(
              width: width,
              height: height,
              color: Colors.grey[200],
              child: const Center(child: CircularProgressIndicator()),
            ),
          )
        : SvgPicture.asset(
            path,
            fit: fit ?? BoxFit.contain,
            colorFilter: colorFilter,
          );

    if (height != null || width != null) {
      return SizedBox(height: height, width: width, child: svgWidget);
    }

    return svgWidget;
  }
}

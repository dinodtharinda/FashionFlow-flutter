import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
    imageUrl: imageUrl,
    fit: BoxFit.contain,
    placeholder: (context, url) => Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        color: Colors.grey[300],
        width: double.infinity,
      ),
    ),
    errorWidget: (context, url, error) => Container(
      color: Colors.red,
      child: const Center(child: Text('Error loading image')),
    ),
                );
  }
}

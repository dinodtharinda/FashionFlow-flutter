import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    Key? key,
    required this.imageUrl,
    this.loading = false,
  }) : super(key: key);

  final String imageUrl;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.contain,
      width: double.infinity,
      placeholder: (context, url) => loading
          ?  Center(
              child: CircularProgressIndicator(color: Theme.of(context).primaryColorDark,),
            )
          : Shimmer.fromColors(
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
      cacheKey: imageUrl,
    );
  }
}

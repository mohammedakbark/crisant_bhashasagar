import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImg extends StatelessWidget {
  final String path;
  const CustomNetworkImg({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.contain,
      imageUrl: path,
      errorListener: (value) {},
      errorWidget: (context, url, error) => Text("Image not Found"),
    );
  }
}

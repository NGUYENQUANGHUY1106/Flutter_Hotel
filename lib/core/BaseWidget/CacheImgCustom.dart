import 'package:book_hotel/core/util/UtilColors.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

// ignore: must_be_immutable
class CacheImgCustom extends StatelessWidget {
  String url;
  CacheImgCustom({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(
          color: UtilColors.primaryKeyColor,
        )),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        fit: BoxFit.cover,
      ),
    );
  }
}

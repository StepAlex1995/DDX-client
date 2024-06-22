import 'package:flutter/material.dart';

import '../../config.dart';

class ServerImage extends StatelessWidget {
  final String filename;
  final double? width;
  final double? height;
  final String token;

  const ServerImage(
      {super.key,
      required this.filename,
      this.width,
      this.height,
      required this.token});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "${Config.server}/api/file/download/${filename.replaceFirst("image/", "")}",
      height: height,
      fit: BoxFit.contain,
      headers: {
        'Authorization': 'bearer $token',
      },
      frameBuilder: (_, image, loadingBuilder, __) {
        if (loadingBuilder == null) {
          return SizedBox(
            height: height,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        return image;
      },
      loadingBuilder: (BuildContext context, Widget image,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return image;
        return SizedBox(
          height: height,
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          ),
        );
      },
      errorBuilder: (_, __, ___) => Image.asset(
        'assets/img/person_photo_err.png',
        width: width,
        height: height,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}

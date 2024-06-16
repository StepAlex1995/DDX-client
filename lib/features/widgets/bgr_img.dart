import 'package:flutter/material.dart';

class BgrImg extends StatelessWidget {
  const BgrImg({super.key, required this.assetImg});

  final AssetImage assetImg;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.black, Colors.black12],
              begin: Alignment.bottomCenter,
              end: Alignment.center,
            ).createShader(bounds),
        blendMode: BlendMode.darken,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: assetImg, //'assets/img/bgr_auth1.png'),
                  fit: BoxFit.cover,
                  colorFilter: const ColorFilter.mode(
                    Colors.black45,
                    BlendMode.darken,
                  ))),
        ));
  }
}

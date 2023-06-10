import 'package:flutter/material.dart';

class NetworkImageWidget extends StatelessWidget {
  const NetworkImageWidget(
      {Key? key,
      required this.image,
      this.width = 50,
      this.height = 50,
      this.fit})
      : super(key: key);

  final String image;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      height: height,
      width: width,
      fit: fit,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(
        value: downloadProgress.progress,
        color: Colors.brown,
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}

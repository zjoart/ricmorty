import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ricmort/src/utils/responsive.dart';

class NetworkImageWidget extends StatelessWidget {
  const NetworkImageWidget(
      {Key? key,
      required this.image,
      this.width = 100,
      this.height = 100,
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
      progressIndicatorBuilder: (_, url, downloadProgress) => Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.xMargin(_, 15),
            vertical: SizeConfig.yMargin(_, 15)),
        child: CircularProgressIndicator(
          value: downloadProgress.progress,
          color: Colors.brown,
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}

import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.height = 50, this.width = 50});
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: height,
        height: width,
        margin: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: const CircularProgressIndicator(
          color: Colors.brown,
        ),
      ),
    );
  }
}

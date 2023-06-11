import 'package:ricmort/src/presentation/characters/widgets/image_widget.dart';
import 'package:flutter/material.dart';

@immutable
class CharacterWidget extends StatelessWidget {
  const CharacterWidget({super.key, required this.image, required this.name});
  final String image;
  final String name;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              spreadRadius: 0,
              offset: const Offset(0, 2),
              color: Colors.black.withOpacity(0.1),
            )
          ],
        ),
        child: NetworkImageWidget(
          image: image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

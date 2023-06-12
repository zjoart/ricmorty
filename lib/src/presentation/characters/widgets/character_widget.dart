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
          child: Stack(
            children: [
              const SizedBox(
                height: 100,
                width: 100,
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                top: 0.0,
                child: NetworkImageWidget(
                  image: image,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: ([...Colors.primaries]..shuffle())[0],
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: const Offset(0, 1),
                              color: Theme.of(context)
                                  .secondaryHeaderColor
                                  .withOpacity(0.06))
                        ],
                      ),
                      child: Text(
                        name,
                        style: const TextStyle().copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      )))
            ],
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ricmort/src/data/models/character.dart';
import 'package:ricmort/src/presentation/characters/widgets/character_detail_widget.dart';
import 'package:ricmort/src/presentation/characters/widgets/image_widget.dart';
import 'package:ricmort/src/utils/responsive.dart';

class CharacterDetailScreen extends StatelessWidget {
  const CharacterDetailScreen({super.key, required this.character});
  final Character character;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          SizedBox(
            height: SizeConfig.yMargin(context, 100),
            width: SizeConfig.xMargin(context, 100),
            child: NetworkImageWidget(
              image: character.image,
              height: SizeConfig.yMargin(context, 100),
              width: SizeConfig.xMargin(context, 100),
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: CharacterDetailWidget(
                character: character,
              ))
        ],
      )),
    );
  }
}

import 'package:ricmort/src/data/models/character.dart';
import 'package:flutter/material.dart';

class CharacterDetailWidget extends StatelessWidget {
  final Character character;
  const CharacterDetailWidget({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).primaryTextTheme.headlineSmall?.copyWith(
        fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white);
    final leadText = [
      "Name",
      "Gender",
      "Species",
    ];
    final subText = [character.name, character.gender, character.species];
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          border: Border.all(color: Colors.black.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 1),
                color: Theme.of(context).secondaryHeaderColor.withOpacity(0.06))
          ],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(children: [
        ...List.generate(
            leadText.length,
            (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 49,
                        child: Text(
                          "${leadText[index]}:",
                          style: style,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(subText[index], style: style),
                    ],
                  ),
                )),
      ]),
    );
  }
}

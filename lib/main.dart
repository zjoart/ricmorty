import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ricmort/src/di/main_di_module.dart';
import 'package:ricmort/src/presentation/characters/ui/character_screen.dart';

void main() {
  DIRegistration().configure(GetIt.I);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ricmort',
      home: CharactersScreen(),
    );
  }
}

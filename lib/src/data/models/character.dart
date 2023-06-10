import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

@JsonSerializable()
class Character extends Equatable {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;
  final String url;
  final String created;

  const Character(
      {required this.name,
      required this.image,
      required this.created,
      required this.status,
      required this.url,
      required this.gender,
      required this.id,
      required this.species});

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterToJson(this);

  @override
  List<Object?> get props =>
      [name, image, created, status, url, gender, id, species];
  @override
  bool? get stringify => true;
}

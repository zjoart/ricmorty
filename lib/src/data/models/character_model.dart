import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ricmort/src/data/models/character.dart';
import 'package:ricmort/src/data/models/info.dart';
part 'character_model.g.dart';

@JsonSerializable()
final class CharacterModel extends Equatable {
  final InfoModel info;
  final List<Character> results;

  const CharacterModel({
    required this.info,
    required this.results,
  });

  @override
  List<Object?> get props => [info, results];

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterModelToJson(this);
}

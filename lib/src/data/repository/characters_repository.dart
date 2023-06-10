import 'package:ricmort/src/data/models/character_model.dart';

typedef RequestResponse = ({CharacterModel? response, String? error});

abstract class CharactersRepository {
  Future<RequestResponse> getCharacters({String nextPageUrl});
}

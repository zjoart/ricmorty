import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:ricmort/src/data/models/character_model.dart';
import 'package:ricmort/src/data/repository/characters_repository.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final Client client;
  CharactersRepositoryImpl(this.client);

  @override
  Future<RequestResponse> getCharacters({String? nextPageUrl}) async {
    try {
      String url = switch (nextPageUrl) {
        (String url) => url,
        _ => "https://rickandmortyapi.com/api/character",
      };

      var client = Client();
      final result = await client.get(
        Uri.parse(url),
      );

      if (result.statusCode == 200) {
        final jsonMap = await json.decode(result.body);

        return Future.value(
            (response: CharacterModel.fromJson(jsonMap), error: null));
      } else {
        return (response: null, error: 'An error occurred ');
      }
    } on SocketException {
      return (
        response: null,
        error: "Please check your internet connectivity and try again"
      );
    } on HandshakeException {
      return (
        response: null,
        error:
            "Something went wrong processing your request please and try again"
      );
    } catch (e) {
      return (response: null, error: e.toString());
    }
  }
}

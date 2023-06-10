import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:ricmort/src/data/repository/characters_repository.dart';
import 'package:ricmort/src/data/repository/characters_repository_impl.dart';

class DIRegistration {
  void configure(GetIt getIt) {
    final httpClient = Client();

    getIt.registerLazySingleton<CharactersRepository>(
        () => CharactersRepositoryImpl(httpClient));
  }
}

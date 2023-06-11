import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'package:mockito/mockito.dart';
import 'package:ricmort/src/data/models/character_model.dart';
import 'package:ricmort/src/data/repository/characters_repository.dart';
import 'package:ricmort/src/data/repository/characters_repository_impl.dart';
import 'package:ricmort/src/presentation/characters/bloc/main_bloc.dart';
import 'package:ricmort/src/presentation/characters/bloc/main_event.dart';
import 'package:ricmort/src/presentation/characters/bloc/main_state.dart';

import 'src/mock_data.dart';
import 'unit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CharactersRepositoryImpl>()])
void main() {
  group('Ricmorty Tests', () {
    late MainPageBloc mainBloc;
    late CharactersRepository repo;

    setUp(() {
      repo = MockCharactersRepositoryImpl();
      mainBloc = MainPageBloc(InitialMainPageState(), repo);
    });
    tearDown(() {
      mainBloc.close();
    });
    test('GetTestDataOnMainPageEvent Success', () async {
      final response =
          (error: null, response: CharacterModel.fromJson(charactersJsonMock));
      when(repo.getCharacters()).thenAnswer((_) async => response);

      expectLater(
        mainBloc.stream,
        emitsInOrder([
          isA<LoadingMainPageState>(),
          isA<SuccessfulMainPageState>(),
        ]),
      );

      mainBloc.add(const GetTestDataOnMainPageEvent());
    });

    test('GetTestDataOnMainPageEvent Empty State', () async {
      final charactersEmptyJsonMock = {
        "info": {
          "count": 826,
          "pages": 42,
          "next": "https://rickandmortyapi.com/api/character?page=2",
          "prev": null
        },
        "results": []
      };
      final response = (
        error: null,
        response: CharacterModel.fromJson(charactersEmptyJsonMock)
      );
      when(repo.getCharacters()).thenAnswer((_) async => response);

      expectLater(
        mainBloc.stream,
        emitsInOrder([
          isA<LoadingMainPageState>(),
          isA<UnSuccessfulMainPageState>(),
        ]),
      );

      mainBloc.add(const GetTestDataOnMainPageEvent());
    });

    test('GetTestDataOnMainPageEvent Error State', () async {
      const response = (error: "An Error occurred", response: null);
      when(repo.getCharacters()).thenAnswer((_) async => response);
      expectLater(
        mainBloc.stream,
        emits(isA<LoadingMainPageState>()),
      );

      mainBloc.add(const GetTestDataOnMainPageEvent());
    });
    test('AddMoreDataOnMainPageEvent Pagination Success Test', () async {
      final responseOne =
          (error: null, response: CharacterModel.fromJson(charactersJsonMock));
      final responseTwo = (
        error: null,
        response: CharacterModel.fromJson(charactersJsonMockTwo)
      );
      when(repo.getCharacters()).thenAnswer((_) async => responseOne);
      const pageUrl = 'https://rickandmortyapi.com/api/character?page=2';
      when(repo.getCharacters(nextPageUrl: pageUrl))
          .thenAnswer((_) async => responseTwo);

      expectLater(
        mainBloc.stream,
        emitsInOrder([
          isA<LoadingMainPageState>(),
          isA<SuccessfulMainPageState>(),
        ]),
      ).then((_) {
        // final currentState = mainBloc.state;
        expectLater(
          mainBloc.stream,
          emitsInOrder([
            isA<SuccessfulMainPageState>(),
            isA<SuccessfulMainPageState>(),
          ]),
        );
        mainBloc.add(const AddMoreDataOnMainPageEvent(pageUrl));
      });
      mainBloc.add(const GetTestDataOnMainPageEvent());
    });
  });
}

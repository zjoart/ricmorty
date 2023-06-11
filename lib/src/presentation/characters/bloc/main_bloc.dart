import 'package:ricmort/src/data/repository/characters_repository.dart';
import 'package:ricmort/src/presentation/characters/bloc/main_event.dart';
import 'package:ricmort/src/presentation/characters/bloc/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final CharactersRepository _charactersRepository;

  MainPageBloc(
    MainPageState initialState,
    this._charactersRepository,
  ) : super(initialState) {
    on<GetTestDataOnMainPageEvent>(
      (event, emitter) => _getDataOnMainPageCasino(event, emitter),
    );
    on<DataLoadedOnMainPageEvent>(
      (event, emitter) => _dataLoadedOnMainPageCasino(event, emitter),
    );
    on<AddMoreDataOnMainPageEvent>(
      (event, emitter) => _addMoreDataOnMainPageCasino(event, emitter),
    );
  }

  Future<void> _dataLoadedOnMainPageCasino(
    DataLoadedOnMainPageEvent event,
    Emitter<MainPageState> emit,
  ) async {
    if (event.model != null && event.model!.results.isNotEmpty) {
      emit(SuccessfulMainPageState(
          characters: event.model!.results,
          nextPageUrl: event.model?.info.next ?? ''));
    } else {
      emit(
          UnSuccessfulMainPageState(reason: 'No characters as of this moment'));
    }
  }

  Future<void> _getDataOnMainPageCasino(
    GetTestDataOnMainPageEvent event,
    Emitter<MainPageState> emit,
  ) async {
    emit(LoadingMainPageState());
    final RequestResponse res = await _charactersRepository.getCharacters();

    if (res.error != null) {
      emit(ErrorMainPageState(error: res.error!));
      return;
    }
    add(DataLoadedOnMainPageEvent(res.response));
  }

  _addMoreDataOnMainPageCasino(
    AddMoreDataOnMainPageEvent event,
    Emitter<MainPageState> emit,
  ) async {
    if (state is SuccessfulMainPageState) {
      final currentState = state as SuccessfulMainPageState;
      if (!currentState.loadingMoreData &&
          currentState.nextPageUrl.isNotEmpty) {
        emit(currentState.copyWith(loadingMoreData: true, error: ''));
        final RequestResponse res = await _charactersRepository.getCharacters(
            nextPageUrl: event.nextPageUrl);

        emit(currentState.copyWith(
            loadingMoreData: false,
            nextPageUrl: res.response?.info.next ?? '',
            characters: res.error != null
                ? null
                : [...currentState.characters, ...res.response!.results],
            error: res.error));
      } else if (currentState.nextPageUrl.isEmpty) {
        emit(currentState.copyWith(
            loadingMoreData: false, error: "End of Result List"));
      }
    }
  }
}

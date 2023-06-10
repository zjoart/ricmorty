import 'package:ricmort/src/data/models/character.dart';
import 'package:ricmort/src/data/repository/characters_repository.dart';
import 'package:ricmort/src/presentation/characters/bloc/main_bloc.dart';
import 'package:ricmort/src/presentation/characters/bloc/main_event.dart';
import 'package:ricmort/src/presentation/characters/bloc/main_state.dart';
import 'package:ricmort/src/presentation/characters/widgets/character_detail_widget.dart';
import 'package:ricmort/src/presentation/characters/widgets/character_widget.dart';
import 'package:ricmort/src/presentation/characters/widgets/dialog.dart';
import 'package:ricmort/src/presentation/characters/widgets/error_widget.dart';
import 'package:ricmort/src/presentation/characters/widgets/loading_widget.dart';
import 'package:ricmort/src/presentation/characters/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@immutable
class CharactersScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final _search = TextEditingController();

  CharactersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F2F0),
        body: BlocProvider(
          create: (blocContext) => MainPageBloc(
            InitialMainPageState(),
            GetIt.I.get<CharactersRepository>(),
          )..add(const GetTestDataOnMainPageEvent()),
          child: BlocConsumer<MainPageBloc, MainPageState>(
            listener: (context, state) {
              if (state is SuccessfulMainPageState && state.error.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  state.error,
                  style: const TextStyle().copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.red.withOpacity(0.8)),
                )));
              }
            },
            builder: (blocContext, state) {
              return switch (state) {
                InitialMainPageState() ||
                LoadingMainPageState() =>
                  const LoadingWidget(),
                SuccessfulMainPageState() => SuccessDisplay(
                    state: state,
                    scrollController: _scrollController,
                    search: _search),
                ErrorMainPageState(error: String error) => ErrorDisplay(
                    error: error,
                    retry: true,
                    ontap: () {
                      blocContext
                          .read<MainPageBloc>()
                          .add(const GetTestDataOnMainPageEvent());
                    }),
                UnSuccessfulMainPageState(reason: String reason) =>
                  ErrorDisplay(error: reason),
              };
            },
          ),
        ),
      ),
    );
  }
}

class SuccessDisplay extends StatelessWidget {
  const SuccessDisplay(
      {super.key,
      required this.state,
      required this.search,
      required this.scrollController});
  final SuccessfulMainPageState state;
  final TextEditingController search;
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 15,
        ),
        SearchWidget(controller: search),
        const SizedBox(
          height: 25,
        ),
        ValueListenableBuilder(
            valueListenable: search,
            builder: (_, value, child) {
              final characters = switch (value.text) {
                "" => state.characters,
                (String s) => state.characters
                    .where((c) => c.toString().contains(s.toLowerCase()))
                    .toList(),
              };

              return characters.isEmpty
                  ? const ErrorDisplay(error: "No result for search")
                  : Expanded(
                      child: ListView.builder(
                        cacheExtent: double.maxFinite,
                        controller: scrollController
                          ..addListener(() {
                            if (scrollController.offset ==
                                    scrollController.position.maxScrollExtent &&
                                !state.loadingMoreData) {
                              if (!state.loadingMoreData) {
                                context.read<MainPageBloc>().add(
                                    AddMoreDataOnMainPageEvent(
                                        state.nextPageUrl));
                              }
                            }
                          }),
                        itemCount: state.loadingMoreData
                            ? (characters.length + 1)
                            : characters.length,
                        itemBuilder: (context, index) {
                          bool showLoading = state.loadingMoreData &&
                              index == characters.length;

                          return showLoading
                              ? const LoadingWidget(height: 20, width: 20)
                              : GestureDetector(
                                  onTap: () {
                                    showAnimatedDialog(
                                        context,
                                        CharacterDetailWidget(
                                          character: characters[index],
                                        ));
                                  },
                                  child: CharacterWidget(
                                    image: characters[index].image,
                                    name: characters[index].name,
                                  ),
                                );
                        },
                      ),
                    );
            })
      ],
    );
  }
}

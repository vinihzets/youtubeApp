import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:youtube_app/core/architeture/bloc_state.dart';
import 'package:youtube_app/core/helpers/hud_mixins.dart';
import 'package:youtube_app/features/home/domain/usecases/get_suggestions_usecase.dart';
import 'package:youtube_app/features/home/domain/usecases/get_youtube_usecase.dart';
import 'package:youtube_app/features/home/presentation/bloc/home_event.dart';

class HomeBloc with HudMixins {
  GetYoutubeUseCase getYoutubeUseCase;
  GetSuggestionsUseCase getSuggestionsUseCase;

  late StreamController<BlocState> _state;
  Stream<BlocState> get state => _state.stream;

  late StreamController<HomeEvent> _event;
  Sink<HomeEvent> get event => _event.sink;

  late StreamController<BlocState> _stateSearch;
  Stream<BlocState> get stateSearch => _stateSearch.stream;

  HomeBloc(this.getYoutubeUseCase, this.getSuggestionsUseCase) {
    _state = StreamController.broadcast();
    _event = StreamController.broadcast();

    _stateSearch = StreamController.broadcast();

    _event.stream.listen(_mapListenEvent);
  }

  dispatchEvent(HomeEvent event) {
    _event.add(event);
  }

  dispatchState(BlocState state) {
    _state.add(state);
  }

  dispatchStateSearch(BlocState state) {
    _stateSearch.add(state);
  }

  _mapListenEvent(HomeEvent event) {
    if (event is HomeEventGetSuggestions) {
      getSuggestions(event.context, event.query);
    }
  }

  getYoutube(BuildContext context) async {
    final request = await getYoutubeUseCase.get();
    request.fold((left) {
      showSnack(context, left.message);
    }, (right) {});
  }

  getSuggestions(BuildContext context, String query) async {
    final suggestionsRequest =
        await getSuggestionsUseCase.getSuggestions(query);
    suggestionsRequest.fold((left) {
      showSnack(context, left.message);
    }, (right) {
      dispatchStateSearch(BlocStableState(data: right));
    });
  }
}

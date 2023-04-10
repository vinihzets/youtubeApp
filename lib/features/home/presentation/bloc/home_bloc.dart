import 'dart:async';

import 'package:youtube_app/core/architeture/bloc_state.dart';
import 'package:youtube_app/features/home/presentation/bloc/home_event.dart';

class HomeBloc {
  late StreamController<BlocState> _state;
  Stream<BlocState> get state => _state.stream;

  late StreamController<HomeEvent> _event;
  Sink<HomeEvent> get event => _event.sink;

  HomeBloc() {
    _state = StreamController.broadcast();
    _event = StreamController.broadcast();

    _event.stream.listen(_mapListenEvent);
  }

  dispatchEvent(HomeEvent event) {
    _event.add(event);
  }

  dispatchState(BlocState state) {
    _state.add(state);
  }

  _mapListenEvent(HomeEvent event) {}
}

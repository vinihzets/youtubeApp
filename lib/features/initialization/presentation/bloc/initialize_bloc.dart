import 'dart:async';

import 'package:youtube_app/core/archiceture/bloc_state.dart';
import 'package:youtube_app/core/helpers/hud_mixins.dart';
import 'package:youtube_app/features/initialization/presentation/bloc/initialize_event.dart';

class InitializeBloc with HudMixins {
  late StreamController<BlocState> _state;
  Stream<BlocState> get state => _state.stream;

  late StreamController<InitializeEvent> _event;
  Sink<InitializeEvent> get event => _event.sink;

  InitializeBloc() {
    _state = StreamController.broadcast();
    _event = StreamController.broadcast();

    _event.stream.listen(_mapListenEvent);
  }

  dispatchEvent(InitializeEvent event) {
    _event.add(event);
  }

  dispatchState(BlocState state) {
    _state.add(state);
  }

  _mapListenEvent(InitializeEvent event) {
    if (event is InitializeNavigate) {
      navigateRemoveUntil(event.context, event.routeName);
    }
  }
}

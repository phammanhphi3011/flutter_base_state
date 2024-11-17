import 'dart:async';

import 'base_event.dart';
import 'base_state.dart';

abstract class BaseBloc<Event extends BaseEvent, State extends BaseState> {
  final _stateController = StreamController<State>.broadcast();
  final _eventController = StreamController<Event>();

  Stream<State> get state => _stateController.stream;
  Sink<Event> get event => _eventController.sink;

  BaseBloc() {
    _eventController.stream.listen((event) async {
      final nextState = await mapEventToState(event);
      if (!_stateController.isClosed) {
        _stateController.add(nextState);
      }
    });
  }

  Future<State> mapEventToState(Event event);

  void emit(State state) {
    if (!_stateController.isClosed) {
      _stateController.add(state);
    }
  }

  void dispose() {
    _stateController.close();
    _eventController.close();
  }
}

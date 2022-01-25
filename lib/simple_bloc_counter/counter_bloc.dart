import 'dart:async';

import 'package:my_bloc/simple_bloc_counter/counter_state.dart';

class CounterBloc {
  final CounterState _counterState;

  CounterBloc(this._counterState) {
    // Whenever there is a new event, we want to map it to a new state
    _counterEventController.stream.listen(_mapEventToState);
  }

  /// Two controllers one for handling state and one for handling event
  final _counterStateController = StreamController<CounterState>();
  final _counterEventController = StreamController<CounterEvent>();

  /// A sink and stream for each controller
  StreamSink<CounterState> get _counterStateSink =>
      _counterStateController.sink;

  Stream<CounterState> get counterStateStream => _counterStateController.stream;

  // Stream<CounterEvent> get _counterEventStream => _counterEventController.stream;
  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  void _mapEventToState(CounterEvent event) {
    /// Application logic comes here
    if (event == CounterEvent.incrementEvent) _counterState.counter++;
    if (event == CounterEvent.decrementEvent) _counterState.counter--;

    _counterState.errorMessage = null;
    if (_counterState.counter < 0) {
      _counterState.counter = 0;
      _counterState.errorMessage = "Cannot reduce below zero.";
    }

    /// do not forget to push the state to the sink to get its value updates in the UI
    _counterStateSink.add(_counterState);
  }

  void dispose() {
    _counterStateController.close();
    _counterEventController.close();
  }
}

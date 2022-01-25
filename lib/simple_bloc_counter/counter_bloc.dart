import 'dart:async';

import 'package:my_bloc/simple_bloc_counter/counter_state.dart';

class CounterBloc {
  CounterBloc(this._counterState) {
    // Whenever there is a new event, we want to map it to a new state
    _counterEventController.stream.listen(_mapEventToState);
  }

  CounterState _counterState;

  /// Two controllers
  final _counterStateController = StreamController<CounterState>();
  final _counterEventController = StreamController<CounterEvent>();

  /// A sink and stream for each controller
  StreamSink<CounterState> get _counterStateSink => _counterStateController.sink;
  Stream<CounterState> get counterStateStream => _counterStateController.stream;

  Stream<CounterEvent> get _counterEventStream => _counterEventController.stream;
  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  void _mapEventToState(CounterEvent event) {
    if (event == CounterEvent.incrementEvent) _counterState.counter++;
    if (event == CounterEvent.decrementEvent) _counterState.counter--;
    _counterStateSink.add(_counterState);
  }

  void dispose() {
    _counterStateController.close();
    _counterEventController.close();
  }
}

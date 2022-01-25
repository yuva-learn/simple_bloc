import 'package:flutter/material.dart';
import 'package:my_bloc/simple_bloc_counter/counter_bloc.dart';
import 'package:my_bloc/simple_bloc_counter/counter_state.dart';

class SimpleCounterScreen extends StatefulWidget {
  const SimpleCounterScreen({Key? key}) : super(key: key);

  @override
  _SimpleCounterScreenState createState() => _SimpleCounterScreenState();
}

class _SimpleCounterScreenState extends State<SimpleCounterScreen> {
  late CounterBloc counterBloc;
  CounterState counterState = CounterState();

  @override
  void initState() {
    super.initState();
    counterBloc = CounterBloc(counterState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc: Counter app"),
      ),
      body: StreamBuilder(
        initialData: counterState,
        stream: counterBloc.counterStateStream,
        builder: (BuildContext context, AsyncSnapshot<CounterState> snapshot) {
          print("Stream incoming: ${snapshot}");
          return _getUIWidget(snapshot.data);
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            onPressed: () {
              counterBloc.counterEventSink.add(CounterEvent.incrementEvent);
              // BlocProvider.of<CounterBloc>(context).add(CounterEvent.incrementEvent);
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              counterBloc.counterEventSink.add(CounterEvent.decrementEvent);
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }

  Widget _getUIWidget(CounterState? counterState) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '${counterState?.counter}',
            style: Theme.of(context).textTheme.headline1,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    counterBloc.dispose();
  }
}

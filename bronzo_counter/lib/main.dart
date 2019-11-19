import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// counter events
enum CounterEvent { increment, decrement }

// counter state is represented by an int

// Counter bloc
class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    if (event == CounterEvent.decrement) {
      yield currentState - 1;
    } else if (event == CounterEvent.increment) {
      yield currentState + 1;
    }
  }
}
// bloc delegate

class MyBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print("onEvent: $event | state : ${bloc.currentState}");
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    // TODO: implement onError
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print("onTransition: $transition | state : ${bloc.currentState}");
  }
}

void main() {
  BlocSupervisor.delegate = MyBlocDelegate();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter',
      home: MultiBlocProvider(
        providers: [
          BlocProvider<CounterBloc>(
            builder: (BuildContext context) => CounterBloc(),
          ),
          BlocProvider<ColorBloc>(
            builder: (BuildContext context) => ColorBloc(),
          ),
          BlocProvider<SecondCounterBloc>(
            builder: (BuildContext context) =>
                SecondCounterBloc(BlocProvider.of<ColorBloc>(context)),
          ),
          BlocProvider<IconBloc>(
            builder: (BuildContext context) => IconBloc(),
          )
        ],
        child: CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);
    ColorBloc colorBloc = BlocProvider.of<ColorBloc>(context);
    SecondCounterBloc secondCounterBloc =
        BlocProvider.of<SecondCounterBloc>(context);
    IconBloc iconBloc = BlocProvider.of<IconBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          BlocBuilder<SecondCounterBloc, int>(
            builder: (context, count) {
              return CircleAvatar(
                backgroundColor: Colors.red,
                child: Text(
                  "$count",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              );
            },
          ),
          BlocBuilder<ColorBloc, Color>(
            builder: (context, color) {
              return FloatingActionButton(
                  backgroundColor: Colors.grey,
                  child: BlocBuilder<IconBloc, IconData>(
                    builder: (context, icon) {
                      return Icon(
                        icon,
                        color: color,
                      );
                    },
                  ),
                  onPressed: () {
                    colorBloc.dispatch(ColorEvent.toggle);
                    iconBloc.dispatch(IconEvent.toggle);
                  });
            },
          ),
          BlocBuilder<CounterBloc, int>(
            builder: (context, count) {
              return Center(
                child: Text(
                  '${count}',
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton(
            child: Icon(Icons.remove),
            onPressed: () {
              counterBloc.dispatch(CounterEvent.decrement);
              secondCounterBloc.dispatch(SecondCounterEvent.decrement);
            },
          ),
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              counterBloc.dispatch(CounterEvent.increment);
              secondCounterBloc.dispatch(SecondCounterEvent.increment);
            },
          ),
        ],
      ),
    );
  }
}

// color event
enum ColorEvent { toggle }

// color state is a color

// color bloc
class ColorBloc extends Bloc<ColorEvent, Color> {
  @override
  Color get initialState => Colors.white;

  @override
  Stream<Color> mapEventToState(ColorEvent event) async* {
    if (event == ColorEvent.toggle) {
      if (currentState == Colors.red) {
        yield Colors.white;
      } else if (currentState == Colors.white) {
        yield Colors.red;
      }
    }
  }
}

// icon event
enum IconEvent { toggle }
// icon state is an icon

// icon bloc
class IconBloc extends Bloc<IconEvent, IconData> {
  @override
  IconData get initialState => Icons.play_arrow;

  @override
  Stream<IconData> mapEventToState(IconEvent event) async* {
    if (event == IconEvent.toggle) {
      yield currentState == Icons.play_arrow ? Icons.pause : Icons.play_arrow;
    }
  }
}

// second counter event
enum SecondCounterEvent { increment, decrement }

// second counter state is an int

// second counter Bloc
class SecondCounterBloc extends Bloc<SecondCounterEvent, int> {
  final ColorBloc colorBloc;

  SecondCounterBloc(@required this.colorBloc) : assert(colorBloc != null);
  @override
  int get initialState => 0;

  @override
  Stream<int> mapEventToState(SecondCounterEvent event) async* {
    if (colorBloc.currentState == Colors.red) {
      if (event == SecondCounterEvent.decrement) {
        yield currentState - 1;
      } else if (event == SecondCounterEvent.increment) {
        yield currentState + 1;
      }
    }
  }
}

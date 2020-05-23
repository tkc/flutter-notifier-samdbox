import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:example/state/counter_state.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: AppState());
  }
}

class AppState extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<AppState> {
  @override
  Widget build(BuildContext context) {
    return StateNotifierProvider<CounterStateNotifier, CounterState>(
      create: (_) => CounterStateNotifier(),
      child: MaterialApp(
          initialRoute: '/first_screen',
          routes: <String, WidgetBuilder>{
            '/first_screen': (context) => FirstScreen(),
            '/second_screen': (context) => SecondScreen(),
          }),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                context
                    .select<CounterState, int>((state) => state.count)
                    .toString(),
              ),
              RaisedButton(
                child: Text('to Second'),
                onPressed: () {
                  Navigator.pushNamed(context, '/second_screen');
                },
              ),
            ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {context.read<CounterStateNotifier>().increment()},
        label: Text('1'),
        icon: Icon(Icons.add),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                context
                    .select<CounterState, int>((state) => state.count)
                    .toString(),
              ),
              RaisedButton(
                child: Text('to First'),
                onPressed: () {
                  Navigator.pop(context, '/second_screen');
                },
              ),
            ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => {context.read<CounterStateNotifier>().increment()},
        label: Text('1'),
        icon: Icon(Icons.add),
      ),
    );
  }
}

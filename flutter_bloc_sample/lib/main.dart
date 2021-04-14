import 'package:flutter/material.dart';
import 'package:flutter_bloc_sample/bloc.dart';
import 'package:flutter_bloc_sample/data.dart';
import 'package:flutter_bloc_sample/event.dart';
import 'package:flutter_bloc_sample/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bloc Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: createColor(Color(0xFF4422FF)),
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

MaterialColor createColor(Color color) {
  List strengths = <double>[.05];
  Map swatch = <int, Color>{};
  final int r = color.red;
  final int g = color.green;
  final int b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1*i);
  }
  strengths.forEach((strength){
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
        r+((ds<0?r:(255-r)) * ds).round(),
        g+((ds<0?g:(255-r)) * ds).round(),
        b+((ds<0?b:(255-r)) * ds).round(),
        1
    );
  });

  return MaterialColor(color.value, swatch);
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<UserData> widgets = [];
  MyBloc _bloc;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      _bloc..add(DataRefresh());
    });
  }

  @override
  void initState() {
    super.initState();
    _bloc = MyBloc();
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<MyBloc, DataState>(
                bloc: _bloc..add(DataFetched()),
                builder: (context, state) {
                  return Center(
                    child: FutureBuilder<List<UserData>>(
                        future: _bloc.loadData(),
                        builder: (BuildContext context, AsyncSnapshot<List<UserData>> snapshot){
                          widgets.clear();
                          if (snapshot.data != null) {
                            for (int i = 0; i < snapshot.data.length; i++) {
                              widgets.add(snapshot.data[i]);
                            }
                            return Text('${state}\nfuture builder : \n${snapshot.data[0].toString()}\n${snapshot.data[1].toString()}\n\n');
                          } else {
                            return Text('${state}\nfuture builder in preparation!\n');
                          }
                        }
                    ),
                  );
                }
            ),
            Text(
              'Refreshed Json Data on Bloc\nYou have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

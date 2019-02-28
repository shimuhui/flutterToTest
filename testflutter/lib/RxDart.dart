import 'package:flutter/material.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new BlocProvider(
      child: new MaterialApp(
        title: 'Welcome to Flutter',
        theme: new ThemeData(
          primarySwatch: Colors.red,
        ),
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Welcome to Flutter'),
          ),
          body: new Home(),
        ),
      ),
    );
  }
}

class BlocProvider extends InheritedWidget {
  CountBLoC bLoC = CountBLoC();

  BlocProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static CountBLoC of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider).bLoC;
}

class CountBLoC {
  int _count = 0;
  var _subject = BehaviorSubject<int>();

  Stream<int> get stream => _subject.stream;
  int get value => _count;

  increment() {
    _subject.add(++_count);
  }

  del() {
    _subject.add(--_count);
  }

  dispose() {
    _subject.close();
  }
}


class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomeState();;
  }
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context);
    // TODO: implement build
    return new Stack(
      children: <Widget>[
        new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Center(
              child: StreamBuilder<int>(
                  stream: bloc.stream,
                  initialData: 0,
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    return Text(
                      'You hit me: ${snapshot.data} times',
                    );
                  })
            ),
          ],
        ),
        new Positioned(
          right: 30.0,
          bottom: 30.0,
          child: new FloatingActionButton(onPressed: () {
            Navigator.push(context, new MaterialPageRoute(
                builder: (context) => new Child()
            ));
          },
            child: new Icon(Icons.navigate_next)
          )
        ),
        new Positioned(
            left: 30.0,
            bottom: 30.0,
            child: RaisedButton(
              onPressed: () => bloc.del(),
              child: Icon(Icons.delete),
            ),
        )
      ],
    );
  }
}

class Child extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ChildState();;
  }
}

class ChildState extends State<Child> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context);
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('child'),
      ),
      body: new Stack(
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Center(
                child: StreamBuilder<int>(
                    stream: bloc.stream,
                    initialData: bloc.value,
                    builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                      return Text(
                        'You hit me: ${snapshot.data} times',
                      );
                    })
              )
            ],
          ),
          new Positioned(
              right: 30.0,
              bottom: 30.0,
              child: FloatingActionButton(
                onPressed: ()=> bloc.increment(),
                child: Icon(Icons.add),
              ),
          )
        ],
      ),
    );
  }
}
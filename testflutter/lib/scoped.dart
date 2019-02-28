import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  CountModel countModel = CountModel();
  @override
  Widget build(BuildContext context) {
    return ScopedModel<CountModel>(
      model: countModel,
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

class CountModel extends Model{
  int _count = 0;
  get count => _count;

  void increment(){
    _count++;
    notifyListeners();
  }

  void del(){
    _count = 0;
    notifyListeners();
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
    final countModel = ScopedModel.of<CountModel>(context, rebuildOnChange: true);
    // TODO: implement build
    return new Stack(
      children: <Widget>[
        new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Center(
              child: new Text(countModel.count.toString()),
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
            child: new RaisedButton(onPressed: () {
              countModel.del();
            },
              child: new Icon(Icons.delete)
            )
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
    // TODO: implement build
    return new ScopedModelDescendant<CountModel>(
        builder: (context, child, model) {
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
                      child: new Text( model.count.toString()),
                    ),
                  ],
                ),
                new Positioned(
                    right: 30.0,
                    bottom: 30.0,
                    child: new FloatingActionButton(
                      child: new Icon(Icons.add),
                      onPressed: () {
                        model.increment();
                      },
                    ))
              ],
            ),
          );
    });
  }
}
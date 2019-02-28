import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

// 主入口
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('MyApp入口--build');
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          "/red": (BuildContext context) => new Red(),
          "/green": (BuildContext context) => new Green(),
          "/yellow": (BuildContext context) => new Yellow(),
          "/blue": (BuildContext context) => new Blue(),
          "/home": (BuildContext context) => new Home(),
        },
        home: new Home()
    );
  }
}
 class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _HomeState();
  }
 }

 class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('home'),
      ),
      body: new Column(
        children: <Widget>[
          new RaisedButton(
            child: new Text('red'),
            onPressed: () {
              Navigator.of(context).pushNamed('/red');
            }
          )
        ],
      ),
    );
  }
 }

class Red extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _RedState();
  }
}

class _RedState extends State<Red> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Red'),
      ),
      body: new Column(
        children: <Widget>[
          new RaisedButton(
              child: new Text('green'),
              onPressed: () {
                Navigator.of(context).pushNamed('/green');
              }
          )
        ],
      )
    );
  }
} class Green extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _GreenState();
  }
}

class _GreenState extends State<Green> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Green'),
      ),
      body: new Column(
        children: <Widget>[
          new RaisedButton(
              child: new Text('yellow'),
              onPressed: () {
                Navigator.of(context).pushNamed('/yellow');
              }
          )
        ],
      )
    );
  }
}

class Yellow extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _YellowState();
  }
}

class _YellowState extends State<Yellow> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Yellow'),
      ),
      body: new Column(
        children: <Widget>[
          new RaisedButton(
              child: new Text('home'),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/home', ModalRoute.withName('/home'));
              }
          )
        ],
      )
    );
  }
}

class Blue extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _BlueState();
  }
}

class _BlueState extends State<Blue> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Blue'),
      ),
    );
  }
}






import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: new ListView(
          children: [
            new Image.asset(
              'images/tx.jpeg',
              height: 300.0,
              fit: BoxFit.cover,
            ),
            new Text('Oeschinen Lake Campground'),
            new Text('Kandersteg, Switzerland'),
            new Icon(
              Icons.star,
              color: Colors.red[500],
            ),
            new Text('41')
          ],
        ),
      ),
    );
  }
}

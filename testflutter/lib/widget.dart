import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:convert';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getHttp();
    return new MaterialApp(
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
    );
  }

  get() async {
    var httpClient = new HttpClient();
    var uri = 'http://localhost:3000/api/getCompany';
    String result;

    try {
      var request = await httpClient.getUrl(Uri.parse(uri));
      var response = await request.close();

      if (response.statusCode == HttpStatus.OK) {
        var responseBody = await response.transform(utf8.decoder).join();
        var data = json.decode(responseBody);

        result = data['msg'];
      } else {
        result =
        'Error getting IP address:\nHttp status ${response.statusCode}';
      }
    } catch (exception) {
      result = 'Failed getting IP address';
    }
    print(result);

  }

  void getHttp() async {
    try {
      Response responseGet;
      Response responsePost;
      var response;
      Dio dio = new Dio();

      responseGet = await Dio().get("http://localhost:3000/api/getCompany");
//      responseGet = await dio.get("/test?id=12&name=wendu");
//      responseGet = await dio.get("/test", queryParameters: {"id": '12', "name": "wendu"});
//      responsePost = await dio.post("http://localhost:3000/api/user/login", data: {"email": 'shimuhui@frogshealth.com', "password": "123456"});
//      response = await Future.wait([dio.get("http://localhost:3000/api/getCompany"), dio.post("http://localhost:3000/api/user/login", data: {"email": 'shimuhui@frogshealth.com', "password": "123456"})]); // 并发请求
//      print(response);
      response = await dio.download("https://img.alicdn.com/tfs/TB1ZkoLukCWBuNjy0FaXXXUlXXa-966-644.jpg_490x490q100.jpg", "aa.jpg");
      print(response);
      response = await dio.post(
        "http://www.dtworkroom.com/doris/1/2.0.0/test",
        data: {"aa": "bb" * 22},
        onUploadProgress: (int sent, int total) {
          print("$sent $total");
        },
      );
      return print(responsePost);
    } catch (e) {
      return print(e);
    }
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: <Widget>[
        new Image.asset('images/tx.jpeg', height: 240.0, width: double.infinity, fit: BoxFit.cover,),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: <Widget>[
           new Title(),
           new Star()
         ],
        ),
        new IconButton(),
        new BottomText()
      ],
    );
  }
}

class Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: new Text('Oeschinen Lake Campground', style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
          ),
          new Text('Kandersteg, Switzerland',
            style: new TextStyle(
              color: Colors.grey[500],
            ))
        ],
      ),
    );
  }
}

class Star extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Row(
//        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Icon(
            Icons.star,
            color: Colors.red[500]
          ),
          new Text('41')
        ],
      ),
    );
  }
}

class IconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Color color = Theme.of(context).primaryColor;

    buildButtonColumn(IconData icon, String label) {
      return new Container(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: new Icon(
                icon,
                color: color,
              ),
            ),
            new Text(
                label,
                style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    color: color
                )
            )
          ],
        ),
      );
    }

    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildButtonColumn(Icons.call, 'CALL'),
          buildButtonColumn(Icons.near_me, 'ROUTE'),
          buildButtonColumn(Icons.share, 'SHARE'),
        ],
      ),
    );
  }
}

class BottomText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Text(
        '''
Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
        ''',
        softWrap: true,
      ),
    );
  }
}
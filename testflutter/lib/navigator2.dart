import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          "/demo1": (BuildContext context) => new Demo1(),
        },
        home: new MainPageWidget());
  }
}

class MainPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MainPageState();
  }
}
class MainPageState extends State<MainPageWidget> {
  int _tabIndex = 0;
  var tabImages;
  var appBarTitles = ['首页', '商铺', '消息', '我的'];

  /*
   * 根据image路径获取图片
   * 这个图片的路径需要在 pubspec.yaml 中去定义
   */
  Image getTabImage(path) {
    return new Image.asset(path, width: 20.0, height: 20.0);
  }

  /*
   * 根据索引获得对应的normal或是press的icon
   */
  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }
  /*
   * 获取bottomTab的颜色和文字
   */
  Text getTabTitle(int curIndex) {
    if (curIndex == _tabIndex) {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(color: const Color(0xff63ca6c)));
    } else {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(color: const Color(0xff888888)));
    }
  }
  /*
   * 存储的四个页面，和Fragment一样
   */
  var _bodys;

  void initData() {
    /*
      bottom的按压图片
     */
    tabImages = [
      [
        getTabImage('images/ic_home_normal.png'),
        getTabImage('images/ic_home_press.png')
      ],
      [
        getTabImage('images/ic_shop_normal.png'),
        getTabImage('images/ic_shop_press.png')
      ],
      [
        getTabImage('images/ic_msg_normal.png'),
        getTabImage('images/ic_msg_press.png')
      ],
      [
        getTabImage('images/ic_my_normal.png'),
        getTabImage('images/ic_my_press.png')
      ]
    ];

    _bodys = [
      new HomePage(),
      new ShopPage(),
      new MsgPage(),
      new MyPage(context)
    ];
  }

  @override
  Widget build(BuildContext context) {
    initData();
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text("主页"),
      ),
      body: _bodys[_tabIndex],
      bottomNavigationBar: new BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
              icon: new Icon(Icons.access_alarms), title: getTabTitle(0)),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.access_alarms), title: getTabTitle(1)),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.access_alarms), title: getTabTitle(2)),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.access_alarms), title: getTabTitle(3)),
        ],
        //设置显示的模式
        type: BottomNavigationBarType.fixed,
        //设置当前的索引
        currentIndex: _tabIndex,
        //tabBottom的点击监听
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomeState();
  }
}

class HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: new Center(child: new RaisedButton(onPressed: _pushPage,child: new Text("跳转"))),
      ),
    );
  }
  _pushPage() {
//    Navigator.of(context).pushNamed("/demo1");
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new Demo1();
    },));
  }
}

class ShopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: new Center(child:new Text("shop")),
      ),
    );
  }
}
class MsgPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: new Center(child:new Text("消息")),
      ),
    );
  }
}

class MyPage extends StatelessWidget {
  var parentContext;
  MyPage(this.parentContext);
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: new PageWidget(parentContext),
      routes: <String,WidgetBuilder>{
        "/demo1":(BuildContext context)=>new Demo1(),
      },
    );
  }
}

class PageWidget extends StatefulWidget {
  var parentContext;
  PageWidget(this.parentContext);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new PageState();
  }
}

class PageState extends State<PageWidget> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(child: new RaisedButton(onPressed: _pushPage,child: new Text("跳转"),),),
    );
  }
  _pushPage(){
     Navigator.of(widget.parentContext).pushNamed("/demo1");
//    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
//      return new Demo1();
//    }));
  }
}

class Demo1 extends StatelessWidget {
  @override
  Widget build(context) {
    return new MaterialApp(
      title: 'demo',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('demo'),
        ),
        body: new Center(
          child: new Text('demo'),
        ),
      ),
    );
  }
}
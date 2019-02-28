import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


void main() => runApp(new MyApp());

// 主入口
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('MyApp入口--build');
    print('MyApp Context = ${context.hashCode}');
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        "/getout": (BuildContext context) => new Out(),
      },
      home: new Home()
    );
  }
}

// 底导部分
class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomeState();
  }
}

class _HomeState extends State<Home> {


  int _currentIndex = 0;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('Home--创建');
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('Home--卸载');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('Home--销毁');
  }

  @override
  Widget build(BuildContext context) {
    print('Home--build');
    print('Home Context = ${context.hashCode}');
    final List<Widget> _children = [
      new Left(),
      new CenterLeft(),
      new CenterRight(),
      new Right2(),
    ];
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('home'),
          backgroundColor: Colors.purple,
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: new BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          //设置显示的模式
          type: BottomNavigationBarType.fixed,
          items: [
            new BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Left'),
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.add),
              title: new Text('CenterLeft'),
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.remove),
              title: new Text('CenterRight'),
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.person),
              title: new Text('Right'),
            ),
          ],
        ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

// 左底导对应页面 -- 主要验证有MaterialApp包裹, 内部跳转
class Left extends StatefulWidget {
//  @override
//  createState() => _LeftState();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LeftState();
  }
}

class _LeftState extends State<Left> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('Left--创建');
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('Left--卸载');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('Left--销毁');
  }

  @override
  Widget build(BuildContext context) {
    print('Left--build');
    print('Left Context = ${context}');
    return new MaterialApp(
      routes: <String, WidgetBuilder>{
        "/leftchildchild": (BuildContext context) => new LeftChildChild(),
        "/leftchildchild2": (BuildContext context) => new LeftChildChild2(),
      },
      home: new LeftChild(),
    );
  }
}


class LeftChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('LeftChild--build');
    print('LeftChild Context = ${context}');
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Left'),
      ),
      backgroundColor: Colors.grey,
      body: new Column(
        children: <Widget>[
          new Center(
            child: new RaisedButton(
              child: new Text('get child'),
              onPressed: () {
//                Navigator.of(context).pushNamed('/leftchildchild');
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new LeftChildChild()
                ));
              },
            )
          ),
          new Center(
            child: new RaisedButton(
              child: new Text('get child2'),
              onPressed: () {
//                Navigator.of(context).pushNamed('/leftchildchild2');
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new LeftChildChild2()
                ));
              },
            )
          )
        ]
      ),
    );
  }
}

class LeftChildChild extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _LeftChildChildState();
  }
}

class _LeftChildChildState extends State<LeftChildChild> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('LeftChildChild--创建');
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('LeftChildChild--卸载');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('LeftChildChild--销毁');
  }
  @override
  Widget build(BuildContext context) {
    print('LeftChildChild--build');
    print('LeftChildChild Context = ${context.widget}');
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('LeftChildChild'),
      ),
      backgroundColor: Colors.green,
      body: new Column(
        children: <Widget>[
          new Center(
              child: new RaisedButton(
                child: new Text('get child2'),
                onPressed: () {
//                    Navigator.of(context).pushNamed('/rightchildchild2');
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (context) => new In()
                  ));
                },
              )
          )
        ]
      )
    );
  }
}

class LeftChildChild2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('LeftChildChild2--build');
    print('LeftChildChild2 Context = ${context.hashCode}');
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('LeftChildChild2'),
      ),
      backgroundColor: Colors.green,
    );
  }
}

// 右底导对应页面 -- 主要验证MaterialApp包裹的情况下, 内部页面需要全屏跳转的情况
class Right extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print('Right--build');
    print('Right Context = ${context.hashCode}');
    final BuildContext contextP = context;
    return new MaterialApp(
      routes: <String, WidgetBuilder>{
        "/rightchildchild": (BuildContext context) => new RightChildChild(),
        "/rightchildchild2": (BuildContext context) => new RightChildChild2(contextP),
        "/getin": (BuildContext context) => new In(),
      },
      home: new RightChild(context),
    );
  }
}

class Right2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RightState();
  }
}

class _RightState extends State<Right2> {

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('Right2--创建');
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('Right2--卸载');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('Right2--销毁');
  }

  @override
  Widget build(BuildContext context) {
    print('Right--build');
    print('Right Context = ${context.hashCode}');
    final BuildContext contextP = context;
    return new MaterialApp(
      routes: <String, WidgetBuilder>{
        "/rightchildchild": (BuildContext context) => new RightChildChild(),
        "/rightchildchild2": (BuildContext context) => new RightChildChild2(contextP),
        "/getin": (BuildContext context) => new In(),
      },
      home: new RightChild(context),
    );
  }
}


class RightChild extends StatefulWidget {
  final BuildContext parentContext;

  RightChild(this.parentContext);



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _RightChildState();
  }
}

class _RightChildState extends State<RightChild> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('RightChild--创建');
  }

  @override
  void didUpdateWidget(RightChild oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('RightChild--更新完毕');
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('RightChild--卸载');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('RightChild--销毁');
  }
  @override
  Widget build(BuildContext context) {
    print('RightChild--build');
    print('RightChild Context = ${context.hashCode}');
    print('RightChild ParentContext = ${widget.parentContext.hashCode}');
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Right'),
      ),
      backgroundColor: Colors.grey,
      body: new Column(
          children: <Widget>[
            new Center(
                child: new RaisedButton(
                  child: new Text('get child'),
                  onPressed: () {
//                    Navigator.of(context).pushNamed('/rightchildchild');
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) => new RightChildChild()
                    ));
                  },
                )
            ),
            new Center(
                child: new RaisedButton(
                  child: new Text('get child2'),
                  onPressed: () {
//                    Navigator.of(context).pushNamed('/rightchildchild2');
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) => new RightChildChild2(widget.parentContext)
                    ));
                  },
                )
            )
          ]
      ),
    );
  }
}


class RightChild2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print('RightChild2--build');
    print('RightChild2 Context = ${context.hashCode}');
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Right'),
      ),
      backgroundColor: Colors.grey,
      body: new Column(
          children: <Widget>[
            new Center(
                child: new RaisedButton(
                  child: new Text('get child'),
                  onPressed: () {
//                    Navigator.of(context).pushNamed('/rightchildchild');
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) => new RightChildChild()
                    ));
                  },
                )
            ),
            new Center(
                child: new RaisedButton(
                  child: new Text('get child2'),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/rightchildchild2');
//                    Navigator.push(context, new MaterialPageRoute(
//                        builder: (context) => new RightChildChild2(widget.parentContext)
//                    ));
                  },
                )
            )
          ]
      ),
    );
  }
}


class RightChildChild extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _RightChildChildState();
  }
}

// 点击按钮后不需要全屏跳转
class _RightChildChildState extends State<RightChildChild> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print('RightChildChild--创建');
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('RightChildChild--卸载');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('RightChildChild--销毁');
  }
  @override
  Widget build(BuildContext context) {
    print('RightChildChild--build');
    print('RightChildChild Context = ${context.hashCode}');
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('RightChildChild'),
      ),
      backgroundColor: Colors.green,
      body: new Center(
          child: new RaisedButton(
            child: new Text('get in'),
            onPressed: () {
              Navigator.of(context).pushNamed('/getin');
//              Navigator.push(context, new MaterialPageRoute(
//                  builder: (context) => new In()
//              ));
            },
          )
      ),
    );
  }
}

// 点击按钮后需要全屏跳转
class RightChildChild2 extends StatelessWidget {
  final BuildContext parentContext;

  RightChildChild2(this.parentContext);



  @override
  Widget build(BuildContext context) {
    print('RightChildChild2--build');
    print('RightChildChild2 Context = ${context.hashCode}');
    print('RightChildChild2 parentContext = ${parentContext.hashCode}');
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('RightChildChild2'),
      ),
      backgroundColor: Colors.green,
      body: new Center(
          child: new RaisedButton(
            child: new Text('get out'),
            onPressed: () {
              Navigator.of(parentContext).pushNamed('/getout');
//              Navigator.push(parentContext, new MaterialPageRoute(
//                  builder: (context) => new Out()
//              ));
            },
          )
      ),
    );
  }
}


// 中间底导对应页面 -- 主要验证没有MaterialApp包裹是全屏跳转的
class CenterLeft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new CenterChild();
  }
}

class CenterChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('CenterChild Context = ${context.hashCode}');
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('CenterChild'),
      ),
      backgroundColor: Colors.grey,
      body: new Column(
          children: <Widget>[
            new Center(
                child: new RaisedButton(
                  child: new Text('get child'),
                  onPressed: () {
//            Navigator.of(context).pushNamed('/login');
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) => new LeftChildChild()
                    ));
                  },
                )
            ),
            new Center(
                child: new RaisedButton(
                  child: new Text('get child2'),
                  onPressed: () {
//            Navigator.of(context).pushNamed('/login');
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) => new LeftChildChild2()
                    ));
                  },
                )
            )
          ]
      ),
    );
  }
}

class CenterRight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('CenterRight Context = ${context.hashCode}');
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('CenterRight'),
        ),
        backgroundColor: Colors.grey,
        body: new Column(
            children: <Widget>[
              new Center(
                  child: new RaisedButton(
                    child: new Text('get child'),
                    onPressed: () {
//            Navigator.of(context).pushNamed('/login');
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (context) => new LeftChildChild()
                      ));
                    },
                  )
              ),
              new Center(
                  child: new RaisedButton(
                    child: new Text('get child2'),
                    onPressed: () {
//            Navigator.of(context).pushNamed('/login');
                      Navigator.push(context, new MaterialPageRoute(
                          builder: (context) => new LeftChildChild2()
                      ));
                    },
                  )
              )
            ]
        ),
      ),
    );
  }
}

class In extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('In--build');
    print('In Context = ${context.hashCode}');
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('In'),
      ),
      backgroundColor: Colors.cyanAccent,
      body: new Column(
          children: <Widget>[
            new Center(
                child: new RaisedButton(
                  child: new Text('get back'),
                  onPressed: () {
//                    Navigator.of(context).pushReplacementNamed('/left');
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) => new Left()
                    ));
                  },
                )
            )
          ]
      )
    );
  }
}

class Out extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Out--build');
    print('Out Context = ${context.hashCode}');
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Out'),
      ),
      backgroundColor: Colors.cyanAccent,
      body: new Column(
        children: <Widget>[
          new Center(
            child: new RaisedButton(
              child: new Text('get back'),
              onPressed: () {
//                    Navigator.of(context).pushNamed('/rightchildchild2');
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new In()
                ));
              },
            )
          )
        ]
      )
    );
  }
}
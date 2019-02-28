import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

Map todoList = new Map<int, String>();

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'TODO',
      theme: new ThemeData(
        primaryColor: Colors.purple,
      ),
      home: new Home(),
      routes: <String, WidgetBuilder>{
        '/add': (context) => new Add()
      },
      onGenerateRoute: (RouteSettings settings) {
        print(settings);
        WidgetBuilder builder;
        if (settings.name == '/') {
          builder = (BuildContext context) => new Add();
        } else {
          String param = settings.name.split('/')[2];
          builder = (BuildContext context) => new Add();
        }

        return new MaterialPageRoute(builder: builder, settings: settings);
      }
    );
  }
}


class Home extends StatefulWidget {

  HomeState myState;
  @override
//  createState() => new HomeState();
  HomeState createState(){
    myState = new HomeState();
    return myState;
  }
}


class HomeState extends State<Home> {

  Map homeList = todoList;


  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('TODO'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add, size: 30, color: Colors.red),
            iconSize: 40,
            tooltip: 'add todo',
            onPressed: add,
          ),
        ],
      ),
      body: listView()
    );
  }

  void add() async{
    String result = await Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return new Add();
      },
    ));

    print(result);
  }

  void edit(int i) {
    print(i);
//    Navigator.of(context).pushNamed('/add/' + i.toString());
    Navigator.push<String>(context, new MaterialPageRoute(
      builder: (BuildContext context) {
        return new Add(title: i.toString());
      },
    ));

  }

  void del(int i) {
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
          title: Text('提示'),
          content: Text('确认删除' + homeList[i]),
          actions:<Widget>[
            new FlatButton(
              child:new Text("取消"),
              onPressed: (){
                Navigator.of(context).pop(true);
              },
            ),
            new FlatButton(
              child:new Text("确定"),
              onPressed: (){
                todoList.remove(i);
                setState(() {
                  homeList = todoList;
                });
                Navigator.of(context).pop(true);
              },
            )
          ]
      )
    );
  }

  Widget listView() {

    var list = new List();

    homeList.forEach((k, v) {
      list.add(k);
    });

    final tiles = list.map((i) {
      return new ListTile(
        title: new Text(homeList[i], softWrap: false),
        onTap: () { edit(i); },
        onLongPress: () { del(i); }
      );
    });


    // 添加每个线
    final divided = ListTile.divideTiles(
      context: context,
      color: Colors.black,
      tiles: tiles,
    ).toList();

    return new ListView(
      children: divided,
    );
  }
}

class Add extends StatefulWidget {

  final String title;   // 储存传递过来的参数
  Add({this.title});


  @override
  createState() => new AddState();
}

class AddState extends State<Add> {

  final TextEditingController _controller =  new TextEditingController.fromValue(TextEditingValue());

  AddState() {
    print('构造函数');
  }

  @override
  void initState() {
    print('init state');
    super.initState();
    print(widget.title);
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies');
    super.didChangeDependencies();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    print(context.ancestorWidgetOfExactType(Scaffold));

    final Home widget2 = context.ancestorWidgetOfExactType(Home);
    final HomeState state = widget2?.myState;
    print('widget build');
    print(state);


    // 初始值
    _controller.text = widget.title == null ? '' : todoList[int.parse(widget.title)];
    // 光标到最后
    _controller.selection =  TextSelection.fromPosition(
      TextPosition(
        affinity: TextAffinity.downstream,
        offset: _controller.text.length
      )
    );



    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text(widget.title == null ? 'ADD' : 'EDIT'),
      ),
      body: new Container(
        padding: EdgeInsets.all(20.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
//            new Stack(),
            new TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              //只能输入数字
              inputFormatters: [],
              enableInteractiveSelection: true,
              textDirection: TextDirection.ltr,
              scrollPadding: EdgeInsets.all(100.0),
              autofocus: true,
              onChanged: _textFieldChanged,
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.all(6.0),
                icon: Icon(Icons.text_fields),
                hintText: '请输入todo',
                labelText: '请输入todo',
              ),
            ),
            new Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: new RaisedButton(
                color: Colors.purple,
                textColor: Color(0xFFFFFFFF),
                onPressed: saveTodo,
                child: new Text('保存'),
              ),
            )
          ],
        ),
      )
    );
  }

  @override
  void didUpdateWidget(Add oldWidget) {
    print('组件状态改变：didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    print('移除时：deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('移除时：dispose');
    super.dispose();
  }

  @override
  void reassemble() {
    print('不知道时：reassemble');
  }

  void _textFieldChanged(String str) {
    print(str);
  }

  void saveTodo() {


    if (_controller.text.length == 0) {
      alertModal();
    } else {
      if (widget.title == null) {
        print('add');
        todoList[todoList.length] = _controller.text;
        Navigator.pop(context, 'add1234567890');
      } else {
        print('edit');
        todoList[int.parse(widget.title)] = _controller.text;
        Navigator.pop(context);
      }
    }
  }

  Widget alertModal() {
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: Text('提示'),
        content: Text('请输入todo'),
          actions:<Widget>[
            new FlatButton(
              child:new Text("确定"),
              onPressed: (){
                Navigator.of(context).pop(true);
              },
            )
          ]
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() {
  final store = Store<CountState>(reducer, initialState: CountState.initState());
  runApp(new MyApp(store));
}

class MyApp extends StatelessWidget {
  final Store<CountState> store;

  MyApp(this.store);
  @override
  Widget build(BuildContext context) {
    return StoreProvider<CountState>(
      store: store,
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

/**
 * State中所有属性都应该是只读的
 */
@immutable
class CountState{
  int _count;
  get count => _count;

  CountState(this._count);

  CountState.initState(){ _count = 0;}
}

/**
 * 定义操作该State的全部Action
 * 这里只有增加count一个动作
 */
enum Action{
  increment,
  del
}

/**
 * reducer会根据传进来的action生成新的CountState
 */
CountState reducer(CountState state,action){
  //匹配Action
  if(action == Action.increment){
    return CountState(state.count+1);
  }

  if(action == Action.del){
    return CountState(state.count-1);
  }
  return state;
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

    // TODO: implement build
    return new Stack(
      children: <Widget>[
        new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Center(
              child: StoreConnector<CountState,int>(
                converter: (store) => store.state.count,
                builder: (context, count) {
                  return Text(
                    count.toString(),
                  );
                },
              ),
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
            child: StoreConnector<CountState,VoidCallback>(
              converter: (store) {
                return () => store.dispatch(Action.del);
              },
              builder: (context, callback) {
                return RaisedButton(
                  onPressed: callback,
                  child: Icon(Icons.delete),
                );
              },
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
                child: StoreConnector<CountState,int>(
                  converter: (store) => store.state.count,
                  builder: (context, count) {
                    return Text(
                      count.toString(),
                    );
                  },
                ),
              ),
            ],
          ),
          new Positioned(
              right: 30.0,
              bottom: 30.0,
              child: StoreConnector<CountState,VoidCallback>(
                converter: (store) {
                  return () => store.dispatch(Action.increment);
                },
                builder: (context, callback) {
                  return FloatingActionButton(
                    onPressed: callback,
                    child: Icon(Icons.add),
                  );
                },
              ),
          )
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); //runApp(Widget)：启动Flutter应用；MyApp()：应用的根组件
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      //命名路由使用步骤：1.注册路由表
      routes: {
        'home_route': (context) => MyHomePage(title: 'Flutter Demo Home Route'),
        'new_route': (context) => NewRoute(),
        'setting_route': (context) => RouteSetting(),
        'tip_route': (context) => TipRoute(
              //适配带参命名路由
              text: ModalRoute.of(context).settings.arguments,
            ),
      },
      //名为"home_route"的路由作为应用的home(首页)，会覆盖'home'属性
      initialRoute: 'home_route',
      //名为"new_route"的路由作为应用的home(首页)，会覆盖'home'属性
      //initialRoute: 'new_route',

      //onGenerateRoute属性在打开命名路由时可能会被调用：当调用Navigator.pushNamed(...)打开命名路由时，
      //如果指定的路由名在路由表中已注册，则会调用路由表中的builder函数来生成路由组件；如果路由表中没有注册，
      //才会调用onGenerateRoute来生成路由。注意，onGenerateRoute只会对命名路由生效。
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) {
          String routeName = settings.name;
          print('+++++onGenerateRoute: $routeName');
          //如果访问的路由页需要登录，但当前未登录，则直接返回登录页路由，引导用户登录；其它情况则正常打开路由。
          return NewRoute();
        });
      },

      //onUnknownRoute属性：打开一个不存在的命名路由时会被调用。但若同时存在onGenerateRoute属性和
      //onUnknownRoute属性，那么onUnknownRoute属性会失效。
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) {
          String routeName = settings.name;
          print('-----onUnknownRoute: $routeName');
          return TipTestRoute();
        });
      },
    );
  }
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

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
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
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return NewRoute();
                  },
                  /*fullscreenDialog: true*/
                ));
              },
              child: Text('This is new route'),
              color: Colors.red,
              textColor: Colors.blue,
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TipTestRoute(),
                    ));
              },
              child: Text('路由传值'),
              color: Colors.red,
              textColor: Colors.blue,
            ),
            FlatButton(
              //命名路由使用步骤：2.使用路由名打开新路由
              onPressed: () => Navigator.pushNamed(context, 'new_route'),
              child: Text('通过路由名打开新界面'),
              color: Colors.red,
              textColor: Colors.blue,
            ),
            FlatButton(
              //命名路由使用步骤：2.使用路由名打开新路由
              //onPressed: () => Navigator.pushNamed(context, 'setting_route',arguments: 'hi'),
              onPressed: () =>
                  Navigator.of(context)
                      .pushNamed('setting_route', arguments: '值是通过命名路由传过来的'),
              child: Text('路由名打开新界面并传值'),
              color: Colors.red,
              textColor: Colors.blue,
            ),
            FlatButton(
              onPressed: () async {
                var result = await Navigator.pushNamed(
                    context, 'tip_route', arguments: '值通过路由名带参传过来');
                print('named_tip_route, return value: $result');
              },
              child: Text('路由名带参并传值'),
              color: Colors.blue,
              textColor: Colors.black,
            ),
            FlatButton(
              onPressed: () =>
                  Navigator.pushNamed(context, 'test_OnGenerateRoute')
              ,
              child: Text('OnGenerateRoute'),
              color: Colors.green,
              textColor: Colors.black,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //onPressed: _incrementCounter,
        onPressed: () {
          //或这样写：调用匿名方法
          setState(() {
            _counter++;
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New route'),
      ),
      body: Center(
        child: Text('This is new route'),
      ),
    );
  }
}

class TipRoute extends StatelessWidget {
  final String text;

  //接收一个text参数
  const TipRoute({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('提示'),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(text), //显示上个路由带过来的值
              RaisedButton(
                onPressed: () => Navigator.pop(context, '我是返回值！'), //给上一个路由返回结果
                child: Text('返回'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*class TipTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () async {
          //打开TipRoute并等待返回结果
          var result = await Navigator.push(
            //若不使用关键字await，则直接返回结果，此时打印的是一个对象
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TipRoute(
                        text: "值由上个路由带过来", //给TipRoute传值
                      )));
          print('route return result: $result');
        },
        child: Text("打开新页面"),
      ),
    );
  }
}*/

class TipTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TipTestRouteState();
  }
}

class TipTestRouteState extends State<TipTestRoute> {
  var result;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () async {
          //打开TipRoute并等待返回结果
          result = await Navigator.push(
            //若不使用关键字await，则直接返回结果，此时打印的是一个对象
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      TipRoute(
                        text: "值由上个路由带过来", //给TipRoute传值
                      )));

          print('route return result: $result');
          setState(() {});
        },
        child: Text("打开新页面，返回结果：$result"),
      ),
    );
  }
}

class RouteSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var value = ModalRoute
        .of(context)
        .settings
        .arguments;
    print('named route pass value: $value');

    return Scaffold(
      appBar: AppBar(
        title: Text('命名路由传值'),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(value), //显示上个路由带过来的值
            ],
          ),
        ),
      ),
    );
  }
}

//使用命名路由的好处
//1.语义化更明确。
//2.代码更好维护；如果使用匿名路由，则必须在调用Navigator.push的地方创建新路由页，
//这样不仅需要import新路由页的dart文件，而且这样的代码将会非常分散。
//3.可以通过onGenerateRoute做一些全局的路由跳转前置处理逻辑。
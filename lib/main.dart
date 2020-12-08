import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Model with ChangeNotifier {
  var _list = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  int _value = 0;

  List<int> get list => _list;

  int get value => _value;

  void removeFirstElement() {
    if (list.isNotEmpty) _list.removeAt(0);
    print(_list.length);
    notifyListeners();
  }

  void addElement() {
    _list.add(42);
    print(_list.length);
    notifyListeners();
  }

  void setList(List<int> inList) {
    _list = inList;
    notifyListeners();
  }

  void increaseValue() {
    _value++;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider<Model>(
      create: (context) => Model(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

int c = 0;

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Selector<Model, List<int>>(
        selector: (_, model) => model.list,
        // shouldRebuild: (previous, next) {
        //   print("previous value: $previous");
        //   print("next value: $next");
        //   return previous != next;
        // },
        // shouldRebuild: (previous, next) {
        //   print("previous length: ${previous.length}");
        //   print("next length: ${next.length}");
        //   return previous.length != next.length;
        // },
        child: Text("click (${c++})"),
        builder: (context, model, child) {
          print("got built");
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                    child: child,
                    onPressed: () {
                      // context.read<Model>().increaseValue();
                      context.read<Model>().setList(<int>[1, 2, 3, 4, 5, 6, 7, 8, 9]);
                      // context.read<Model>().addElement();
                      // context.read<Model>().removeFirstElement();
                      // Provider.of<Model>(context, listen: false)
                      //     .removeFirstElement();
                    }),
              ],
            ),
          );
        }
      ),
    );
  }
}

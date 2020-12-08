import 'dart:collection';
import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Model with ChangeNotifier {
  var _set = SplayTreeSet<int>.from(<int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
  var _list = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int _value = 0;

  Set<int> get set => _set;

  List<int> get list => _list;

  int get value => _value;

  void removeFirstElementFromSet() {
    if (_set.isNotEmpty) _set.remove(_set.first);
    print(_set.length);
    notifyListeners();
  }

  void removeFirstElementFromList() {
    // if (list.isNotEmpty) _list.removeAt(0);
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
      body: Selector<Model, Tuple2<List<int>, int>>(
          selector: (_, model) =>
              Tuple2<List<int>, int>(model.list, model.list.length),
          // shouldRebuild: (previous, next) {
          //   print("previous value: $previous");
          //   print("next value: $next");
          //   return previous != next;
          // },
          shouldRebuild: (previous, next) {
            print("previous length: ${previous.item2}");
            print("next length: ${next.item2}");
            return previous.item2 != next.item2;
          },
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
                        // context.read<Model>().removeFirstElementFromSet();
                        // context.read<Model>().increaseValue();
                        // context.read<Model>().setList(<int>[1, 2, 3, 4, 5, 6, 7, 8, 9]);
                        // context.read<Model>().addElement();
                        context.read<Model>().removeFirstElementFromList();
                        // Provider.of<Model>(context, listen: false)
                        //     .removeFirstElement();
                      }),
                ],
              ),
            );
          }),
    );
  }
}

import 'package:employees_children/classes.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Index extends StatelessWidget {
  void _generatorTest(int x) {
    _generator(x).forEach((element) {
      print(element);
    });
  }

  Stream<int> _generator(int x) async* {
    int a = x;
    if (x > 5) yield a += 1;
    yield a += 2;
    yield a += 3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Home page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              onPressed: () => Navigator.pushNamed(context, RouteNames.employeesList),
              child: const Text('Employees List'),
              color: Colors.red[900],
            ),
            FlatButton(
              onPressed: () => Navigator.pushNamed(context, RouteNames.childrenList),
              child: const Text('Children List'),
              color: Colors.red[900],
            ),
          ],
        ),
      ),
      floatingActionButton: IconButton(icon: Icon(Icons.add_circle), onPressed: () => _generatorTest(3)),
    );
  }
}

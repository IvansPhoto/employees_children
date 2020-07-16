import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:employees_children/pages/SelectChildren/SelectChildrenListTitle.dart';
import 'package:employees_children/classes.dart';

class SelectChildren extends StatefulWidget {

  @override
  _SelectChildrenState createState() => _SelectChildrenState();
}

class _SelectChildrenState extends State<SelectChildren> {
  final childrenBox = Hive.box<ChildrenData>(Boxes.childrenBox);

  @override
  Widget build(BuildContext context) {
    EmployeesData employee = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Select children for ${employee == null ? 'New employee' : employee.name}'),
      ),
      body: ValueListenableBuilder(
        valueListenable: childrenBox.listenable(),
        builder: (context, Box<ChildrenData> childrenBox, _) {
          if (childrenBox.values.length == 0)
            return Center(child: const Text('No children in the list'));
          else
            return ListView.builder(
              itemCount: childrenBox.values.length,
              itemBuilder: (context, index) {
                ChildrenData child = childrenBox.getAt(index);
                return Card(
                  elevation: 0,
                  child: SelectChildrenListTitle(theChild: child, theEmployee: employee),
                );
              },
            );
        },
      ),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.add_circle_outline),
        onPressed: () => Navigator.pushNamed(context, RouteNames.newChildren),
      ),
    );
  }
}

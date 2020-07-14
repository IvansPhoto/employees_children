import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:employees_children/pages/SelectChildren/SelectChildrenListTitle.dart';
import 'package:employees_children/classes.dart';

class SelectChildren extends StatefulWidget {
  final EmployeesData employee;

  SelectChildren({this.employee});

  @override
  _SelectChildrenState createState() => _SelectChildrenState();
}

class _SelectChildrenState extends State<SelectChildren> {
  final childrenSelectedList = ChildrenSelectedList();
  final childrenBox = Hive.box<ChildrenData>(Boxes.childrenBox);

  @override
  void initState() {
    childrenSelectedList.childrenList = [];
    print(childrenSelectedList.childrenList ?? 'selectedChildren is null');
    widget.employee.children = HiveList(childrenBox);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Select children for ${widget.employee == null ? 'New employee' : widget.employee.name}'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.check_circle), onPressed: () => Navigator.pop(context, childrenSelectedList.childrenList)),
          IconButton(icon: Icon(Icons.backspace), onPressed: () => Navigator.pop(context))
        ],
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
                  child: SelectChildrenListTitle(theChild: child, theEmployee: widget.employee, childrenList: childrenSelectedList),
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

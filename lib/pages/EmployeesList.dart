import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:employees_children/classes.dart';

class EmployeesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('The list of employees'),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<EmployeesData>(Boxes.employeesBox).listenable(),
        builder: (context, Box<EmployeesData> box, _) {
          if (box.values.isEmpty) return Center(child: const Text("No employees in the list."));
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              EmployeesData theEmployee = box.getAt(index);
              return Card(
                elevation: 0,
                child: ListTile(
                  title: Text('${theEmployee.surName} ${theEmployee.name}'),
                  subtitle: Text(theEmployee.children == null ? 'No children' : 'Children: ${theEmployee.children.length}'),
                  onTap: () => Navigator.of(context).pushNamed(RouteNames.showEmployee, arguments: theEmployee),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.add_circle),
        onPressed: () => Navigator.pushNamed(context, RouteNames.newEmployee),
      ),
    );
  }
}

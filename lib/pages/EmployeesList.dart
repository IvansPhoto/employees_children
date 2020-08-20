import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:employees_children/classes.dart';
import 'package:employees_children/GlobalStore.dart';
import 'package:employees_children/Support.dart';

class EmployeesList extends StatefulWidget {
  @override
  _EmployeesListState createState() => _EmployeesListState();
}

class _EmployeesListState extends State<EmployeesList> {
  final store = gStore.get<GlobalStore>();
  Box<EmployeesData> employeeBox;
  List<EmployeesData> employeeList;

  @override
  void initState() {
    employeeBox = Hive.box<EmployeesData>(Boxes.employeesBox);
    employeeList = Hive.box<EmployeesData>(Boxes.employeesBox).values.where((element) => element.surName.contains('B')).toList();
    super.initState();
  }

  void filter({String searchingText}) {
    setState(() {
      employeeList.where((employee) => employee.name.contains(searchingText) || employee.surName.contains(searchingText) || employee.patronymic.contains(searchingText));
    });

  }

  @override
  Widget build(BuildContext context) {
    print('rebuild');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('The list of employees'),
        actions: [_ButtonAddEmployee()],
      ),
      body: ValueListenableBuilder(
        valueListenable: employeeBox.listenable(), //Using Hive as state management.
        builder: (context, Box<EmployeesData> box, _) {
          print('rebuild Box');
          if (box.values.isEmpty) return Center(child: const Text("No employees in the list.")); //Return a text if there are no records.
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: employeeList.length,
                  itemBuilder: (context, index) {
                    EmployeesData theEmployee = employeeList[index];
                    return Card(
                      elevation: 0,
                      child: ListTile(
                        title: Text('${theEmployee.surName} ${theEmployee.name}'),
                        subtitle: Text(theEmployee.children == null || theEmployee.children.length == 0 ? 'No children' : '${theEmployee.children.length} children'),
                        onTap: () {
                          store.theEmployee = theEmployee; //Put the employee to the Global store
                          Navigator.of(context).pushNamed(RouteNames.showEmployee); //Go to the page for showing of the employee
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 1, 65, 1),
                child: TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(hintText: 'Matches in name or surname', labelText: 'Searching', hintStyle: TextStyle(fontSize: 15)),
                  onChanged: (text) => filter(searchingText: text),
                ),
              )
            ],
          );
        },
      ),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.add_circle),
        onPressed: () => Navigator.pushNamed(context, RouteNames.newEmployee, arguments: true),
        iconSize: 35,
      ),
    );
  }
}

class _ButtonAddEmployee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.get_app),
        onPressed: () {
          GeneratePersons.generateEmployees();
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('An employee has been added.')));
        });
  }
}

import 'package:employees_children/classes.dart';
import 'package:employees_children/pages/ShowEmployee/ActionButtonsEmployee.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ShowEmployee extends StatelessWidget {

  List<Widget> _showChildrenList(List<ChildrenData> _childrenList) {
    List<Widget> _childrenWidgets = [];
    _childrenWidgets.add(Text('Children:'));
    if (_childrenList == null) {
      _childrenWidgets.add(Text('Without children'));
      return _childrenWidgets;
    } else {
      for (int i = 0; i < _childrenList.length; i++) {
        _childrenWidgets.add(Text('${i + 1}:  ${_childrenList[i].surName} ${_childrenList[i].name} ${_childrenList[i].patronymic}'));
      }
    }
    return _childrenWidgets;
  }

  @override
  Widget build(BuildContext context) {
    final EmployeesData employee = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('${employee.name} ${employee.surName}'),
      ),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<EmployeesData>(Boxes.employeesBox).listenable(),
          builder: (context, Box<EmployeesData> box, _) {
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              children: <Widget>[
                RichText(
                    text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    const TextSpan(text: '\nName\n'),
                    TextSpan(text: employee.name ?? 'Not specified'),
                  ],
                )),
                RichText(
                    text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    const TextSpan(text: '\nSurname\n'),
                    TextSpan(text: employee.surName ?? 'Not specified'),
                  ],
                )),
                RichText(
                    text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    const TextSpan(text: '\nBirthday\n'),
                    TextSpan(
                      text: employee.birthdate == null ? 'Not specified' : '${employee.birthdate.year}-${employee.birthdate.month}-${employee.birthdate.day}',
                    ),
                  ],
                )),
                RichText(
                    text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    const TextSpan(text: '\nPosition\n'),
                    TextSpan(text: employee.position ?? 'Not specified'),
                  ],
                )),
                Divider(),
                ..._showChildrenList(employee.children),
                Divider(),
                ActionButtons(employee: employee),
              ],
            );
          }),
    );
  }
}

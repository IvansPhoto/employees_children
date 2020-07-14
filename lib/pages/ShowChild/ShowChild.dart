import 'package:employees_children/classes.dart';
import 'package:employees_children/pages/ShowChild/ActionButtonsChild.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ShowChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ChildrenData child = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('${child.name} ${child.surName}'),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<ChildrenData>(Boxes.childrenBox).listenable(),
        builder: (context, box, _) {
          return ListView(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            children: <Widget>[
              Text('Name: ${child.name ?? 'Not specified'}'),
              Text('Surname: ${child.surName ?? 'Not specified'}'),
              Text('Patronymic: ${child.patronymic ?? 'Not specified'}'),
              Text('Birthday: ${child.birthdate == null ? 'Not specified' : '${child.birthdate.year}-${child.birthdate.month}-${child.birthdate.day}'}'),
            ActionButtonsChild(child: child,)
            ],
          );
        },
      ),
    );
  }
}

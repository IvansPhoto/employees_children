import 'package:flutter/material.dart';
import 'package:employees_children/classes.dart';
import 'package:employees_children/pages/DeleteConfirmation.dart';

class ActionButtons extends StatelessWidget {
	final EmployeesData employee;

	ActionButtons({this.employee});

	@override
	Widget build(BuildContext context) {
		return Row(
			crossAxisAlignment: CrossAxisAlignment.center,
			mainAxisAlignment: MainAxisAlignment.center,
			children: <Widget>[
				FlatButton.icon(
					onPressed: () => Navigator.of(context).pushNamed(RouteNames.newEmployee, arguments: employee),
					icon: Icon(Icons.edit),
					label: Text('Edit'),
				),
				FlatButton.icon(
					onPressed: () => Navigator.push(
						context,
						MaterialPageRoute(builder: (context) => DeleteConfirmation(employee: employee), fullscreenDialog: true),
					),
					icon: Icon(Icons.delete_forever),
					label: Text('Delete'),
				)
				//TODO: modal to confirm delete the employee
			],
		);
	}
}


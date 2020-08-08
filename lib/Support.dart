import 'package:employees_children/classes.dart';

List<SelectedChildren> makeChildrenList({List<ChildrenData> employeeChildren, List<ChildrenData> allChildren}) {
  List<SelectedChildren> finalList = [];
  allChildren.forEach((theChild) {
    finalList.add(SelectedChildren(
      child: theChild,
      selected: employeeChildren.contains(theChild),
    ));
  });
  return finalList;
}

void updateChildren({EmployeesData employee, List<SelectedChildren> selectedChildren}) {
  employee.children.clear();
  selectedChildren.forEach((selectedChild) {
   if (selectedChild.selected) employee.children.add(selectedChild.child);
  });
}

String monthFromNumber(DateTime dateTime) {
  String month;
  switch (dateTime.month) {
    case 1:
      month = 'January';
      break;
    case 2:
      month = 'February';
      break;
    case 3:
      month = 'March';
      break;
    case 4:
      month = 'April';
      break;
    case 5:
      month = 'May';
      break;
    case 6:
      month = 'June';
      break;
    case 7:
      month = 'July';
      break;
    case 8:
      month = 'August';
      break;
    case 9:
      month = 'September';
      break;
    case 10:
      month = 'October';
      break;
    case 11:
      month = 'November';
      break;
    case 12:
      month = 'December';
      break;
  }
  return '${dateTime.day} $month ${dateTime.year}';
}

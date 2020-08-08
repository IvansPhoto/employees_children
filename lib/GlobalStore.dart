import 'package:hive/hive.dart';
import 'package:employees_children/classes.dart';
import 'package:get_it/get_it.dart';

final GetIt gStore = GetIt.instance;

class GlobalStore {
  EmployeesData theEmployee;
//  ChildrenData theChild;
//  List<SelectedChildren> selectedChildren;
}
//
//class StreamServes {
//  final _employeeBox = Hive.box<EmployeesData>(Boxes.employeesBox);
//
//  set addEmployee(EmployeesData newEmployee) => _employeeBox.add(newEmployee);
//
//  EmployeesData getEmployee(int index) => _employeeBox.getAt(index);
//
//  Future<void> removeEmployee(EmployeesData removedEmployee) => removedEmployee.delete();
//
//  Future<void> updateEmployee(EmployeesData updatedEmployee) => updatedEmployee.save();
//}

import 'package:rxdart/rxdart.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'classes.g.dart';

abstract class RouteNames {
  static final index = '/';
  static final employeesList = '/EmployeesList';
  static final showEmployee = '/ShowEmployee';
  static final newEmployee = '/NewEmployee/NewEmployee';
  static final childrenList = '/ChildrenList';
  static final showChild = '/ShowChild';
  static final newChildren = '/NewChild/NewChild';
  static final selectChildren = '/SelectChildren/SelectChildren';
}

abstract class Boxes {
  static final String employeesBox = 'employees';
  static final String childrenBox = 'children';
}

class StreamServes {

//  Future<Box> _employeeBoxFuture = Future(computation)

  final _employeeBox = Hive.box<EmployeesData>(Boxes.employeesBox);
  set addEmployee(EmployeesData newEmployee) => _employeeBox.add(newEmployee);
  EmployeesData getEmployee(int index) => _employeeBox.getAt(index);
  Future<void> removeEmployee(EmployeesData removedEmployee) => removedEmployee.delete();
  Future<void> updateEmployee(EmployeesData updatedEmployee) => updatedEmployee.save();

  var _child = BehaviorSubject<ChildrenData>();
  Stream get child$ => _child.stream;
  ChildrenData get getChild => _child.value;
  set setChild(ChildrenData newChild) => _child.value = newChild;


  final _childrenList = BehaviorSubject<List<ChildrenData>>();
  Stream get childrenList$ => _childrenList.stream;
  List<ChildrenData> get currentChildrenList => _childrenList.value;
  set setChildrenList(List<ChildrenData> newChildrenList) => _childrenList.add(newChildrenList);
}

class ChildrenSelectedList {
  List<ChildrenData> childrenList = [];

  set addChild(ChildrenData child) {
    if (!childrenList.contains(child)) childrenList.add(child);
    childrenList.forEach((theChild) => print(theChild.name));
//    notifyListeners();
  }

  set removeChild(ChildrenData child) {
    if (childrenList.contains(child)) childrenList.remove(child);
    childrenList.forEach((theChild) => print(theChild.name));
//    notifyListeners();
  }
}

@HiveType(typeId: 0)
class EmployeesData extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String surName;

  @HiveField(2)
  String patronymic;

  @HiveField(3)
  DateTime birthdate;

  @HiveField(4)
  String position;

  @HiveField(5)
  HiveList<ChildrenData> children;

  EmployeesData({this.name, this.surName, this.patronymic, this.birthdate, this.position, this.children});
}

@HiveType(typeId: 1)
class ChildrenData extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String surName;

  @HiveField(2)
  String patronymic;

  @HiveField(3)
  DateTime birthdate;

  @HiveField(4)
  EmployeesData parent;

  set setParent(EmployeesData newParent) => parent = newParent;

  ChildrenData({this.name, this.surName, this.patronymic, this.birthdate});
}

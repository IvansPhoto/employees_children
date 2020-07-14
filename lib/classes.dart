import 'package:hive/hive.dart';
part 'classes.g.dart';

abstract class RouteNames {
  static final index = '/';
  static final employeesList = '/EmployeesList';
  static final showEmployee = '/ShowEmployee';
  static final newEmployee = '/NewEmployee/NewEmployee';
  static final childrenList = '/ChildrenList';
  static final showChild = '/ShowChild';
  static final newChildren = '/NewChild/NewChild';
  static final selectChildren = '/SelectChildren';
}

abstract class Boxes {
  static final String employeesBox = 'employees';
  static final String childrenBox = 'children';
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

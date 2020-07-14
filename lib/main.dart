import 'package:employees_children/pages/SelectChildren/SelectChildren.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:employees_children/classes.dart';
import 'package:employees_children/pages/ChildrenList.dart';
import 'package:employees_children/pages/EmployeesList.dart';
import 'package:employees_children/pages/NewChild/NewChild.dart';
import 'package:employees_children/pages/NewEmployee/NewEmployee.dart';
import 'package:employees_children/pages/ShowChild/ShowChild.dart';
import 'package:employees_children/pages/ShowEmployee/ShowEmployee.dart';
import 'package:employees_children/pages/index.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<EmployeesData>(EmployeesDataAdapter());
  Hive.registerAdapter<ChildrenData>(ChildrenDataAdapter());
  await Hive.openBox<EmployeesData>(Boxes.employeesBox);
  await Hive.openBox<ChildrenData>(Boxes.childrenBox);
  runApp(MaterialApp(
    title: 'The EFT test application',
    initialRoute: RouteNames.index,
    routes: {
      RouteNames.index: (BuildContext context) => Index(),
      RouteNames.employeesList: (BuildContext context) => EmployeesList(),
      RouteNames.showEmployee: (BuildContext context) => ShowEmployee(),
      RouteNames.newEmployee: (BuildContext context) => NewEmployee(),
      RouteNames.childrenList: (BuildContext context) => ChildrenList(),
      RouteNames.showChild: (BuildContext context) => ShowChild(),
      RouteNames.newChildren: (BuildContext context) => NewChild(),
      RouteNames.selectChildren: (BuildContext context) => SelectChildren(),
    },
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.red[900],
      primaryColorDark: Colors.red[700],
      primaryColorLight: Colors.red[500],
    ),
    darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red[900],
        primaryColorDark: Colors.red[700],
        primaryColorLight: Colors.red[500],
        buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.normal, height: 15, buttonColor: Colors.red[900]),
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 25, color: Colors.red[900]),
          bodyText2: TextStyle(fontSize: 25, color: Colors.deepOrange),
          caption: TextStyle(fontSize: 10, color: Colors.amber),
          overline: TextStyle(fontSize: 25, color: Colors.blue),
          button: TextStyle(fontSize: 25),
          headline1: TextStyle(fontSize: 25),
        )),
  ));
}

//Необходимо создать приложение на Flutter в котором будет реализована возможность вноса списка сотрудников и их детей.
//Должна быть возможность просмотра "подчиненного списка" детей
//Сцены:

//При открытии приложения появляется список в который можно внести сотрудников. Для внесения необходимы данные:
//1.      Фамилия
//2.      Имя
//3.      Отчество
//4.      Дата рождения
//5.      Должность

//При выборе сотрудника появляется список для ввода детей данного сотрудника, должна быть возможность внесения данных по ребенку:
//1.      Фамилия
//2.      Имя
//3.      Отчество
//4.      Дата рождения

//Должна быть возможность вернуться назад к Родителю.

//В списке сотрудников при наличии у них детей должно отображаться количество детей.

//Вариант хранения данных можно выбрать по своему усмотрению (XML, SQLLite, прочее). Возможен вариант реализации без хранения данных.

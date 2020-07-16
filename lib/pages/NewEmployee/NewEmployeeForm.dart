import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:employees_children/classes.dart';
import 'package:employees_children/pages/SelectChildren/SelectChildren.dart';

class EmployeeForm extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();
  final EmployeesData employee;

  EmployeeForm({this.employee});

  @override
  _EmployeeFormState createState() => _EmployeeFormState();
}

class _EmployeeFormState extends State<EmployeeForm> {
  TextEditingController _nameTEC;
  TextEditingController _surnameTEC;
  TextEditingController _positionTEC;

  DateTime _birthday;
  String _birthdayText;
  HiveList<ChildrenData> _childrenList;

  Box<EmployeesData> employeesBox = Hive.box<EmployeesData>(Boxes.employeesBox);
  Box<ChildrenData> childrenBox = Hive.box<ChildrenData>(Boxes.childrenBox);

  @override
  void initState() {
    print(widget.employee ?? "employee is Null");
    if (widget.employee == null) {
      _nameTEC = TextEditingController();
      _surnameTEC = TextEditingController();
      _positionTEC = TextEditingController();
      _birthday = DateTime.now();
      _birthdayText = '${DateTime.now().year.toString()}-${DateTime.now().month.toString()}-${DateTime.now().day.toString()}';
      _childrenList = HiveList(childrenBox);
    } else {
      _nameTEC = TextEditingController(text: widget.employee.name);
      _surnameTEC = TextEditingController(text: widget.employee.surName);
      _positionTEC = TextEditingController(text: widget.employee.position);
      _birthday = widget.employee.birthdate;
      _birthdayText = '${widget.employee.birthdate.year.toString()}-${widget.employee.birthdate.month.toString()}-${widget.employee.birthdate.day.toString()}';
      _childrenList = widget.employee.children;
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameTEC.dispose();
    _surnameTEC.dispose();
    _positionTEC.dispose();
    super.dispose();
  }

  void _addEmployee() {
    employeesBox.add(EmployeesData(
      name: _nameTEC.text,
      surName: _surnameTEC.text,
      birthdate: _birthday,
      position: _positionTEC.text,
      children: HiveList(childrenBox), //Check output from ChildrenList
    ));
    Navigator.of(context).pop();
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text('The employee has been added.'),
        elevation: 0,
        duration: Duration(seconds: 5),
      ));
  }

  void _updateEmployee() {
    widget.employee.name = _nameTEC.text;
    widget.employee.surName = _surnameTEC.text;
    widget.employee.position = _positionTEC.text;
    widget.employee.birthdate = _birthday;
//    widget.employee.children = HiveList(childrenBox);
    widget.employee.save();
    Navigator.of(context).pop();
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text('The employee has been updated.'),
        elevation: 0,
        duration: Duration(seconds: 5),
      ));
  }

  void _selectChildren(context) {
    print(widget.employee.surName ?? "employee is Null");
    Navigator.pushNamed(context, RouteNames.selectChildren, arguments: widget.employee);
//    List<ChildrenData> children = await Navigator.push(context, MaterialPageRoute(builder: (context) => SelectChildren(employee: widget.employee)));
//    if (children != null) setState(() => _childrenList.addAll(children));
//    children.forEach((element) => print(element.name));
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('${widget.employee.name ?? 'None'} are selected.')));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
          key: widget._formKey,
          autovalidate: true,
          child: ListView(
            children: <Widget>[
              //Name
              TextFormField(
                controller: _nameTEC,
                decoration: const InputDecoration(hintText: 'Name', labelText: "The name"),
                maxLength: 50,
                keyboardType: TextInputType.text,
                validator: (value) => value.isEmpty ? 'Enter the employee name' : null,
              ),
              //Surname
              TextFormField(
                controller: _surnameTEC,
                decoration: const InputDecoration(hintText: 'Surname', labelText: "The surname"),
                maxLength: 50,
                keyboardType: TextInputType.text,
                validator: (value) => value.isEmpty ? 'Enter the employee surname' : null,
              ),
              //Position
              TextFormField(
                controller: _positionTEC,
                decoration: const InputDecoration(hintText: 'Position', labelText: "The position"),
                maxLength: 50,
                keyboardType: TextInputType.text,
                validator: (value) => value.isEmpty ? 'Enter the employee position' : null,
              ),
              //Birthday
              TextField(
                readOnly: true,
                controller: TextEditingController(text: _birthdayText),
                onTap: () => showDatePicker(
                  context: context,
                  initialDate: widget.employee == null ? DateTime.now() : widget.employee.birthdate,
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2021),
                ).then((dateTime) => setState(() {
                      _birthday = dateTime;
                      _birthdayText = '${dateTime.year.toString()}-${dateTime.month.toString()}-${dateTime.day.toString()}';
                    })),
                decoration: const InputDecoration(hintText: 'Birthday', labelText: "The birthday"),
              ),
              RaisedButton(
                elevation: 0,
                onPressed: () => {if (widget._formKey.currentState.validate()) widget.employee == null ? _addEmployee() : _updateEmployee()},
                child: widget.employee == null ? const Text('Submit') : const Text('Update'),
              ),

              RaisedButton.icon(
                onPressed: () {
                  _selectChildren(context);
                },
                icon: Icon(Icons.person_add),
                label: Text('Add a child'),
              ),

              _EmployeeChildrenList(childrenList: _childrenList, employeesBox: employeesBox,),

            ],
          )),
    );
  }
}

class _EmployeeChildrenList extends StatelessWidget {
  final HiveList<ChildrenData> childrenList;
  final Box<EmployeesData> employeesBox;
  _EmployeeChildrenList({this.childrenList, this.employeesBox});

  List<InlineSpan> _childrenListTextSpan(List<ChildrenData> _childrenList) {
    List<InlineSpan>  _childrenWidgets = [];
      for (int i = 0; i < _childrenList.length; i++) {
        _childrenWidgets.add(TextSpan(text:'${i + 1}: ${_childrenList[i].surName} ${_childrenList[i].name} ${_childrenList[i].patronymic} \n'));
      }
    return _childrenWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: employeesBox.listenable(),
      builder: (context, employeesBox, _) {
        if (childrenList == null)
          return Text('Without children');
        else
          return RichText(
            text: TextSpan(
              text: 'Children\n',
              children: [..._childrenListTextSpan(childrenList)],
            ),
          );
      },
    );
  }
}

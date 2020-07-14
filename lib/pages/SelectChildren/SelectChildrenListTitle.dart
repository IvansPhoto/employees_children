import 'package:flutter/material.dart';
import 'package:employees_children/classes.dart';

class SelectChildrenListTitle extends StatefulWidget {
  final ChildrenData theChild;
  final EmployeesData theEmployee;
  final ChildrenSelectedList childrenList;

  SelectChildrenListTitle({this.theChild, this.theEmployee, this.childrenList});

  @override
  _SelectChildrenListTitleState createState() => _SelectChildrenListTitleState();
}

class _SelectChildrenListTitleState extends State<SelectChildrenListTitle> {
  bool _selected = false;

  @override
  void initState() {
    if (widget.theEmployee == null || widget.theEmployee.children == null)
      _selected = false;
    else
      widget.theEmployee.children.forEach((employeeChild) {
        if (identical(employeeChild, widget.theChild)) {
          _selected = true;
        } else {
          _selected = false;
        }
      });

    super.initState();
  }

  void _select() {
    print(widget.childrenList ?? 'selectedChildren is null');
    setState(() {
      _selected = !_selected;
      if (!widget.theEmployee.children.contains(widget.theChild)) widget.theEmployee.children.addAll([...widget.theEmployee.children, widget.theChild]);
      widget.theEmployee.save();
      print(widget.theEmployee.position);
//      _selected ? widget.childrenList.addChild(widget.theChild) : widget.childrenList.removeChild(widget.theChild);
    });
//      if (widget.theEmployee == null) {
//        setState(() {
//          if (_selected) widget.childrenSelectedList.addChild(widget.theChild);
//        });
//
//        if (!_selected && widget.childrenSelectedList.childrenList.contains(widget.theChild)) widget.childrenSelectedList.childrenList.remove(widget.theChild);
//      } else {
//        if (!widget.theEmployee.children.contains(widget.theChild) && _selected) {
//          widget.theEmployee.children.add(widget.theChild);
//          widget.theEmployee.save();
//        }
//        if (widget.theEmployee.children.contains(widget.theChild) && !_selected) {
//          widget.theEmployee.children.remove(widget.theChild);
//          widget.theEmployee.save();
//        }
//      }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${widget.theChild.surName} ${widget.theChild.name} ${widget.theChild.patronymic}'),
      selected: _selected,
      onTap: () => _select(),
      trailing: _selected ? Icon(Icons.check_circle) : Icon(Icons.radio_button_unchecked),
    );
  }
}

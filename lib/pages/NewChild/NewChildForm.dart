import 'package:employees_children/classes.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NewChildForm extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();
  final Box<ChildrenData> childrenBox = Hive.box<ChildrenData>(Boxes.childrenBox);
  final ChildrenData child;

  NewChildForm({this.child});

  @override
  _NewChildFormState createState() => _NewChildFormState();
}

class _NewChildFormState extends State<NewChildForm> {
  TextEditingController _nameTEC;
  TextEditingController _surnameTEC;
  TextEditingController _patronymicTEC;
  DateTime _birthday;
  String _birthdayText;

  @override
  void initState() {
    if (widget.child == null) {
      _nameTEC = TextEditingController();
      _surnameTEC = TextEditingController();
      _patronymicTEC = TextEditingController();
      _birthday = DateTime.now();
      _birthdayText = '${DateTime.now().year.toString()}-${DateTime.now().month.toString()}-${DateTime.now().day.toString()}';
    } else {
      _nameTEC = TextEditingController(text: widget.child.name);
      _surnameTEC = TextEditingController(text: widget.child.surName);
      _patronymicTEC = TextEditingController(text: widget.child.patronymic);
      _birthday = widget.child.birthdate;
      _birthdayText = '${widget.child.birthdate.year.toString()}-${widget.child.birthdate.month.toString()}-${widget.child.birthdate.day.toString()}';
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameTEC.dispose();
    _surnameTEC.dispose();
    _patronymicTEC.dispose();
    super.dispose();
  }

  void _addChild() {
    widget.childrenBox.add(ChildrenData(
      name: _nameTEC.text,
      surName: _surnameTEC.text,
      patronymic: _patronymicTEC.text,
      birthdate: _birthday,
    ));
    Navigator.of(context).pop();
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('The child has been added.'),
      elevation: 0,
      duration: Duration(seconds: 5),
    ));
  }

  void _updateChild() {
	  widget.child.name = _nameTEC.text;
	  widget.child.surName = _surnameTEC.text;
	  widget.child.patronymic = _patronymicTEC.text;
	  widget.child.birthdate = _birthday;
	  widget.child.save();
	  Navigator.of(context).pop();
	  Scaffold.of(context).showSnackBar(SnackBar(
		  content: Text('The employee has been updated.'),
		  elevation: 0,
		  duration: Duration(seconds: 5),
	  ));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
		    key: widget._formKey,
//		    autovalidate: true,
		    child: Column(
			    children: <Widget>[
				    TextFormField(
					    autofocus: true,
					    controller: _nameTEC,
					    decoration: const InputDecoration(hintText: 'Name', labelText: "The name"),
					    maxLength: 50,
					    keyboardType: TextInputType.text,
					    validator: (value) => value.isEmpty ? 'Enter the child name' : null,
				    ),
				    TextFormField(
					    autofocus: true,
					    controller: _surnameTEC,
					    decoration: const InputDecoration(hintText: 'Surname', labelText: "The surname"),
					    maxLength: 50,
					    keyboardType: TextInputType.text,
					    validator: (value) => value.isEmpty ? 'Enter the child surname' : null,
				    ),
				    TextFormField(
					    autofocus: true,
					    controller: _patronymicTEC,
					    decoration: const InputDecoration(hintText: 'Patronymic', labelText: "The patronymic"),
					    maxLength: 50,
					    keyboardType: TextInputType.text,
					    validator: (value) => value.isEmpty ? 'Enter the child patronymic' : null,
				    ),
				    Row(
					    crossAxisAlignment: CrossAxisAlignment.center,
					    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
					    children: <Widget>[
						    RaisedButton(
							    elevation: 0,
							    child: widget.child == null ? const Text('Select birthday') : const Text('Update birthday'),
							    onPressed: () => showDatePicker(
								    context: context,
								    initialDate: widget.child == null ? DateTime.now() : widget.child.birthdate,
								    firstDate: DateTime(1950),
								    lastDate: DateTime(2021),
							    ).then((dateTime) => setState(() {
								    _birthday = dateTime;
								    _birthdayText = '${dateTime.year.toString()}-${dateTime.month.toString()}-${dateTime.day.toString()}';
							    })),
						    ),
						    Text(_birthdayText)
					    ],
				    ),
				    RaisedButton(
					    elevation: 0,
					    onPressed: () => {if (widget._formKey.currentState.validate()) widget.child == null ? _addChild() : _updateChild()},
					    child: widget.child == null ? const Text('Submit') : const Text('Update'),
				    ),

			    ],
		    ));
  }
}

import 'package:flutter/material.dart';
import 'package:employees_children/classes.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:employees_children/Support.dart';

class ChildrenList extends StatefulWidget {
  @override
  _ChildrenListState createState() => _ChildrenListState();
}

class _ChildrenListState extends State<ChildrenList> {
  Iterable<ChildrenData> childrenBox;
  TextEditingController _filter = TextEditingController();

//  List<ChildrenData> filter({List<ChildrenData> listOfChildren, String searchingText}) {
//    print(searchingText);
//    return listOfChildren.where((child) => child.name.contains(searchingText) || child.surName.contains(searchingText) || child.patronymic.contains(searchingText));
//  }
//
//  @override
//  void initState() {
//    childrenBox = Hive.box<ChildrenData>(Boxes.childrenBox)
//        .values
//        .where((child) => child.name.contains(_filter.text) || child.surName.contains(_filter.text) || child.patronymic.contains(_filter.text));
//    super.initState();
//  }

  @override
  Widget build(BuildContext context) {
    print('rebuild ChildrenList');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('The list of children'),
        actions: [_ButtonAddChildren()],
      ),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: Hive.box<ChildrenData>(Boxes.childrenBox).listenable(), //Using Hive as state management.
              builder: (context, Box<ChildrenData> box, _) {
                if (box.values.length == 0) return Center(child: Text('No children in the list')); //Return a text if there are no records.
                return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    ChildrenData theChild = box.getAt(index);
                    return Card(
                      elevation: 0,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text('${theChild.surName} ${theChild.name}'),
                            subtitle: Text(monthFromNumber(theChild.birthdate)),
                            onTap: () => Navigator.of(context).pushNamed(RouteNames.showChild, arguments: theChild),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 1, 65, 1),
            //TODO: create a filtration of all records.
            child: TextFormField(
//              controller: _filter,
              maxLength: 50,
              decoration: const InputDecoration(hintText: 'Matches in name or surname', labelText: 'Searching', hintStyle: TextStyle(fontSize: 15)),
              onChanged: (text) => print(text),
            ),
          )
        ],
      ),
      floatingActionButton: IconButton(
        icon: Icon(Icons.add_circle),
        onPressed: () => Navigator.pushNamed(context, RouteNames.newChildren),
      ),
    );
  }
}

class _ButtonAddChildren extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.get_app),
        onPressed: () {
          GeneratePersons.generateChildren();
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('A child has been added.')));
        });
  }
}

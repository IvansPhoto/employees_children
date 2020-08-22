import 'package:employees_children/GlobalStore.dart';
import 'package:flutter/material.dart';
import 'package:employees_children/classes.dart';
import 'package:hive/hive.dart';
import 'package:employees_children/Support.dart';

class ChildrenList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    gStore<GlobalStore>().boxStreamChildren$.listen((event) {
      gStore<GlobalStore>().setChildrenList(Hive.box<ChildrenData>(Boxes.childrenBox).values.toList());
      print('${event.key} - ${event.value} - ${event.deleted}');
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('The list of children'),
        actions: [
          ButtonAddChildrenEmployee(snackBarText: 'A child has been added.', genChild: true),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: gStore<GlobalStore>().streamChildrenList$,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState != ConnectionState.active) return Center(child: Text('No children in the list')); //Return a text if there are no records.
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      ChildrenData theChild = snapshot.data.elementAt(index);
                      return Card(
                        elevation: 0,
                        child: ListTile(
                          title: Text('${theChild.surName} ${theChild.name}'),
                          subtitle: Text(monthFromNumber(theChild.birthdate)),
                          onTap: () => Navigator.of(context).pushNamed(RouteNames.showChild, arguments: theChild),
                        ),
                      );
                    },
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 1, 65, 1),
            child: TextFormField(
              maxLength: 50,
              decoration: const InputDecoration(hintText: 'Matches in name or surname', labelText: 'Searching', hintStyle: TextStyle(fontSize: 15)),
              onChanged: (text) => gStore<GlobalStore>().filterChildren(text),
            ),
          )
        ],
      ),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.add_circle),
        onPressed: () => Navigator.pushNamed(context, RouteNames.newChildren),
	      iconSize: 35,
      ),
    );
  }
}

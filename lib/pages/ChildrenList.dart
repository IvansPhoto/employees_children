import 'package:employees_children/GlobalStore.dart';
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

  @override
  Widget build(BuildContext context) {

    print('rebuild ChildrenList');
    gStore<GlobalStore>().boxStream$.listen((event) => print('${event.key} - ${event.value} - ${event.deleted}'));

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('The list of children'),
        actions: [_ButtonAddChildren()],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<Object>(
              stream: gStore<GlobalStore>().boxStream$,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print('rebuild boxStream');

                //TODO:Emit the gStore<GlobalStore>().streamChildrenList$ after chaining in the Hive.box
                gStore<GlobalStore>().setChildrenList(Hive.box<ChildrenData>(Boxes.childrenBox).values.toList());

                return Center(
                  child: StreamBuilder(
                    stream: gStore<GlobalStore>().streamChildrenList$,
                    builder: (BuildContext context, AsyncSnapshot<List<ChildrenData>> snapshot) {
                      print('rebuild streamChildrenList');
                      if (snapshot.connectionState !=  ConnectionState.active) return Center(child: Text('No children in the list')); //Return a text if there are no records.
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          ChildrenData theChild = snapshot.data.elementAt(index);
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
                );
              }
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 1, 65, 1),
            child: TextFormField(
              maxLength: 50,
              decoration: const InputDecoration(hintText: 'Matches in name or surname', labelText: 'Searching', hintStyle: TextStyle(fontSize: 15)),
              onChanged: (text) => gStore<GlobalStore>().filter(text),
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

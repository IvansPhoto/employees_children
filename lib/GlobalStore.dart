import 'package:hive/hive.dart';
import 'package:get_it/get_it.dart';
import 'package:employees_children/classes.dart';
import 'package:rxdart/rxdart.dart';

final GetIt gStore = GetIt.instance;

class GlobalStore {
  EmployeesData theEmployee;

//  final _childrenList = BehaviorSubject<List<ChildrenData>>.seeded(Hive.box<ChildrenData>(Boxes.childrenBox).values.toList());
  final _childrenList = BehaviorSubject<List<ChildrenData>>();

  Stream<List<ChildrenData>> get streamChildrenList$ => _childrenList.stream;

  List<ChildrenData> get currentChildrenList => _childrenList.value;

  void setChildrenList(List<ChildrenData> newChildrenList) => _childrenList.add(newChildrenList);

  void addChildren(ChildrenData newChild) => Hive.box<ChildrenData>(Boxes.childrenBox).add(newChild);

  Stream boxStream$ = Hive.box<ChildrenData>(Boxes.childrenBox).watch();

  void filter(String searchingText) {
    _childrenList.add(Hive.box<ChildrenData>(Boxes.childrenBox)
        .values
        .where((child) => child.name.contains(searchingText) || child.surName.contains(searchingText) || child.patronymic.contains(searchingText))
        .toList());
  }
}

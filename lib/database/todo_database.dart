import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_todo/models/todo_model.dart';

enum Filter { all, highPriority, completed }

class TodoData extends ChangeNotifier {
  List<TodoModel> todoList = [];
  final Box _box = Hive.box('myBox');
  List jsonList = [];
  String filter = 'All';
  Filter _currentFilter = Filter.all;

  List get filteredTask {
    switch (_currentFilter) {
      case Filter.highPriority:
        {
          return todoList.where((todo) => todo.priority == 1).toList();
        }
      case Filter.completed:
        {
          return todoList.where((todo) => todo.isChecked == true).toList();
        }
      case Filter.all:
      default:
        {
          return todoList;
        }
    }
  }

  void storeData() {
    jsonList.clear();
    for (var item in todoList) {
      jsonList.add(item.toJson(item));
    }
    _box.put('TODOS', jsonList);
  }

  void getAllTaskFromLocalStorage() {
    jsonList = _box.get('TODOS') ?? [];
    if (jsonList.isNotEmpty) {
      List<TodoModel> myList =
          jsonList.map((item) => TodoModel.fromJson(item)).toList();
      for (TodoModel todoModel in myList) {
        todoList.add(todoModel);
      }
    } else {
      addDummyData();
    }
  }

  void addData(
      {required String title,
      required String description,
      required int priority,
      required String dueDate}) {
    todoList.add(TodoModel(
        title: title,
        description: description,
        priority: priority,
        dueDate: dueDate));
    storeData();
    notifyListeners();
  }

  void changeCheckState(TodoModel todo) {
    todo.togglestate();
    storeData();
    notifyListeners();
  }

  void deleteTodo(TodoModel todo) {
    todoList.remove(todo);
    storeData();
    notifyListeners();
  }

  void notifyEditedTask() {
    storeData();
    notifyListeners();
  }

  void addDummyData() {
    todoList.addAll([
      TodoModel(
          title: 'Task 1',
          description: 'task 1 with high priority',
          priority: 1,
          dueDate: DateTime.now()
              .toString()
              .split(" ")[0]),
      TodoModel(
          title: 'Task 2',
          description: 'task 2 with low priority',
          priority: 2,
          dueDate: DateTime
              .now()
              .toString()
              .split(" ")[0]),
    ]);
  }

  void setFilter(Filter filter) {
    _currentFilter = filter;
    notifyListeners();
  }

}

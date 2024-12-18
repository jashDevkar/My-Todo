import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_todo/models/todo_model.dart';
class TodoData extends ChangeNotifier{
  List<TodoModel> todoList =[];
  final Box _box = Hive.box('myBox');
  List jsonList =[];

  void storeData(){
    jsonList.clear();
    for (var item in todoList) {
      jsonList.add(item.toJson(item));
    }
    _box.put('TODOS', jsonList);
  }

  void getAllTaskFromLocalStorage(){
   jsonList=  _box.get('TODOS') ?? [];
   if(jsonList.isNotEmpty){
     List<TodoModel> myList = jsonList.map((item)=>TodoModel.fromJson(item)).toList();
     for(TodoModel todoModel in myList){
       todoList.add(todoModel);
     }
   }
   else{
     addDummyData();
   }
  }

  void addData({required String title, required String description, required int priority, required String dueDate}){
    todoList.add(TodoModel(title: title, description: description, priority: priority, dueDate: dueDate));
    storeData();
    notifyListeners();
  }

  void changeCheckState(TodoModel todo){
    todo.togglestate();
    storeData();
    notifyListeners();
  }

  void deleteTodo(TodoModel todo){
    todoList.remove(todo);
    storeData();
    notifyListeners();
  }

  void notifyEditedTask(){
    storeData();
    notifyListeners();
  }

  void addDummyData(){
    todoList.addAll([
      TodoModel(title: 'Task 1', description: 'task 1 with high priority ', priority: 1, dueDate: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day).toString().split(" ")[0]),
      TodoModel(title: 'Task 2', description: 'task 2 with low priority description', priority: 2, dueDate: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day).toString().split(" ")[0]),
    ]);
  }

  ///Todo filters

  void getAllTasks(){
    todoList = [];
    getAllTaskFromLocalStorage();
    notifyListeners();
  }

  void getCompletedTask(){
    getAllTaskFromLocalStorage();
    List<TodoModel> _safeList = [];
    for(var todo in todoList){
      if(todo.isChecked){
        _safeList.add(todo);
      }
    }
    todoList = [];
    todoList = _safeList;
    notifyListeners();
  }

  void getHighPriorityTask(){
    getAllTaskFromLocalStorage();
    List<TodoModel> _safeList = [];
    for(var todo in todoList){
      if(todo.priority == 1){
        _safeList.add(todo);
      }
    }
    todoList = [];
    todoList = _safeList;
    notifyListeners();
  }


}
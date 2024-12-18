import 'package:flutter/material.dart';
import 'package:my_todo/components/task_header.dart';
import 'package:my_todo/components/task_lists.dart';
import 'package:my_todo/constants/styles.dart';
import 'package:my_todo/database/todo_database.dart';
import 'package:my_todo/screens/add_task_screen.dart';
import 'package:provider/provider.dart';




class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Filter _filterValue = Filter.all;

  @override
  void initState(){
    super.initState();
    Provider.of<TodoData>(context,listen: false).getAllTaskFromLocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        ///drawer contains Radio to filter task
        ///This filteration happens with enum stored in todo_database file
        drawer: Drawer(
          backgroundColor: Colors.white,
          child:ListView(
            children: [
              const DrawerHeader(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('F i l t e r',style: kFiltertitleStyle,),
                    SizedBox(width: 8.0,),
                    Icon(Icons.filter_alt,color: Colors.blue,),
                  ],
                ),
              ),
              Column(
                children: [
                  ///filter of all tasks
                  ///call setFilter method to change the currentFilter value  in todo_database file
                  ListTile(
                    leading: const Text('All Tasks'),
                    trailing: Radio(
                        activeColor: Colors.blue,
                        value: Filter.all,
                        groupValue: _filterValue,
                        onChanged: (value){
                          ///setting currentFilter value to filter.all
                          Provider.of<TodoData>(context,listen: false).setFilter(value!);
                          setState(() {
                            _filterValue = value;
                          });
                        }),
                  ),///all
                  ListTile(
                    leading: const Text('Completed Tasks'),
                    trailing: Radio(
                        activeColor: Colors.blue,
                        value:Filter.completed,
                        groupValue: _filterValue,
                        onChanged: (value){
                          ///setting currentFilter value to filter.completed
                          Provider.of<TodoData>(context,listen: false).setFilter(value!);
                          setState(() {
                            _filterValue = value;
                          });
                        }),
                  ),///completed
                  ListTile(
                    leading: const Text('High Priority Tasks'),
                    trailing: Radio(
                        activeColor: Colors.blue,
                        value: Filter.highPriority,
                        groupValue: _filterValue,
                        onChanged: (value){
                          ///setting currentFilter value to filter.priority
                            Provider.of<TodoData>(context,listen: false).setFilter(value!);
                          setState(() {
                            _filterValue = value;
                          });
                        }),
                  ),///high

                ],
              )
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: Builder(
            builder: (context){
              return TextButton(
                  onPressed: ()=>Scaffold.of(context).openDrawer(),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.menu),
                    ),
              );
            },
          ),
        ),
        body: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///task header will have information such as total number of task
            TaskHeader(),
            ///task list will build all task having information
            ///title,descripition,priority and due date
            TaskLists(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddTaskScreen()));
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          backgroundColor: Colors.blue,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

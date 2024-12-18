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

  String _filterValue = 'All';

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
                    Icon(Icons.filter_alt),
                  ],
                ),
              ),
              Column(
                children: [
                  ///Todo implement filter of tasks
                  ListTile(
                    leading: const Text('All Tasks'),
                    trailing: Radio(
                        activeColor: Colors.blue,
                        value: 'All',
                        groupValue: _filterValue,
                        onChanged: (value){
                          // Provider.of<TodoData>(context,listen: false).getAllTasks();
                          setState(() {
                            _filterValue = value!;
                          });
                        }),
                  ),
                  ListTile(
                    leading: const Text('Completed Tasks'),
                    trailing: Radio(
                        activeColor: Colors.blue,
                        value:'Completed',
                        groupValue: _filterValue,
                        onChanged: (value){
                          // Provider.of<TodoData>(context,listen: false).getCompletedTask();
                          setState(() {
                            _filterValue = value!;
                          });
                        }),
                  ),
                  ListTile(
                    leading: const Text('High Priority Tasks'),
                    trailing: Radio(
                        activeColor: Colors.blue,
                        value: 'High',
                        groupValue: _filterValue,
                        onChanged: (value){
                          setState(() {
                            // Provider.of<TodoData>(context,listen: false).getHighPriorityTask();
                            _filterValue = value!;
                          });
                        }),
                  ),

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
            TaskHeader(),
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

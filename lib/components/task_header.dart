import 'package:flutter/material.dart';
import 'package:my_todo/constants/styles.dart';
import 'package:my_todo/database/todo_database.dart';
import 'package:provider/provider.dart';

class TaskHeader extends StatelessWidget {
  const TaskHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10.0),
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('My Todo',style: kHeaderTextStyle,),
          Text('${context.watch<TodoData>().todoList.length} Tasks',style: kTaskCountStyle,)
        ],
      ),
    );
  }
}

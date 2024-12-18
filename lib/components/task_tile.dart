import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_todo/constants/styles.dart';

class TaskTile extends StatelessWidget {
  String title;
  String description;
  String dueDate;
  bool isCheck;
  int priority;
  Function changeCheckState;
  Function(BuildContext context) deleteCallBack;
  Function(BuildContext context) editCallBack;

  TaskTile(
      {super.key, required this.title,
      required this.description,
      required this.dueDate,
      required this.isCheck,
      required this.changeCheckState,
      required this.priority,
      required this.deleteCallBack,
      required this.editCallBack});


  ///String date {upcoming ,passed,today}
  String getDueDateText() {
    DateTime taskDueDate = DateTime.parse(dueDate);
    taskDueDate = DateTime(taskDueDate.year, taskDueDate.month, taskDueDate.day);
    DateTime currentDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    if (taskDueDate.isAtSameMomentAs(currentDate)) {
        return 'Today $dueDate';
    } else if (taskDueDate.isAfter(currentDate)) {
        return 'Upcomming $dueDate';
    } else{
        return 'Passed $dueDate';
    }

  }


  @override
  Widget build(BuildContext context) {
    return Slidable(
      ///edit slide
      startActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          ///edit call back
          SlidableAction(onPressed: editCallBack,
            icon: Icons.edit,
            backgroundColor: Colors.blue,
          )
        ],
      ),
      ///delete slide
      endActionPane: ActionPane(
          motion: const StretchMotion(),
          children:[
            ///delete call back
            SlidableAction(onPressed: deleteCallBack,
            icon: Icons.delete,
            backgroundColor: Colors.red,)
          ] ),
      child: Card(
          color: Colors.white,
          elevation: 5.0,
          margin: const EdgeInsets.only(bottom: 10.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ///title and description
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///title
                      Text(
                        title[0].toUpperCase() +
                            title.substring(1, title.length),
                        style: kTodoTitleStyle.copyWith(
                            decoration: isCheck
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),

                      ///description
                      Text(
                        description,
                        style: kTododoDescriptionStyle.copyWith(
                            decoration: isCheck
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),

                      ///date
                      Row(
                        children: [
                          if (priority == 1)
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 15.0,
                            ),
                          const SizedBox(
                            width: 2.0,
                          ),
                          Text(
                            getDueDateText(),
                            style: kDateStyle.copyWith(
                                decoration: isCheck
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                ///checkBox
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Checkbox(
                      value: isCheck,
                      activeColor: Colors.blue,
                      onChanged: (value) {
                        ///checkbox call back function
                        ///this fnction will call another function in todo_database
                        ///and that function will toggle todo with help of this list todo instance
                        changeCheckState();
                      },
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}

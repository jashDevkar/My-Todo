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
  Function(BuildContext) deleteCallBack;
  Function(BuildContext) editCallBack;

  TaskTile(
      {super.key, required this.title,
      required this.description,
      required this.dueDate,
      required this.isCheck,
      required this.changeCheckState,
      required this.priority,
      required this.deleteCallBack,
      required this.editCallBack});

  String getDueDateText() {
    DateTime taskDueDate = DateTime.parse(dueDate);
    taskDueDate =
        DateTime(taskDueDate.year, taskDueDate.month, taskDueDate.day);
    DateTime currentDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    if (taskDueDate.isAtSameMomentAs(currentDate)) {
      return 'Today $dueDate';
    } else if (taskDueDate.isAfter(currentDate)) {
      return 'Upcomming $dueDate';
    } else
      return 'Passed $dueDate';
  }



  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(onPressed: editCallBack,
            icon: Icons.edit,
            backgroundColor: Colors.blue,
          )
        ],
      ),
      endActionPane: ActionPane(
          motion: StretchMotion(),
          children:[
            SlidableAction(onPressed: deleteCallBack,
            icon: Icons.delete,
            backgroundColor: Colors.red,)
          ] ),
      child: Card(
          color: Colors.white,
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 10.0, top: 10.0, bottom: 10.0),
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

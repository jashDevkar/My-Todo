import 'package:flutter/material.dart';
import 'package:my_todo/constants/styles.dart';
import 'package:my_todo/database/todo_database.dart';
import 'package:my_todo/models/todo_model.dart';
import 'package:provider/provider.dart';

class EditTask extends StatefulWidget {

  TodoModel todo;
  EditTask({required this.todo});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  bool editTaskState = true;
  late int _priority;
  late final TodoModel todo;


  @override
  void initState(){
    super.initState();
    ///making clone of todoModel instance
    ///no matter in which instance we make changes
    ///they both point ot same instance
    ///after cloning assigning values to clone of todoModel instance
    todo  = widget.todo;
    assignValues();
  }

  void assignValues(){
    _titleController.text = todo.title;
    _priority= todo.priority ;
    _descriptionController.text = todo.description;
    _dateController.text = todo.dueDate;
  }



  ///date selector
  Future<void> selectDate(context)async{
    DateTime? date = await showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime(2100));
    if(date  != null){
      _dateController.text = date.toString().split(" ")[0];
    }

  }



  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          backgroundColor: Colors.blue,
          title: const Text(
            'Edit task',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 30.0),
          child: Column(
            children: [
              ///title section
              TextField(
                maxLength: 30,
                controller: _titleController,
                decoration:
                kInputFieldDecoration.copyWith(labelText: 'Enter Title'),
              ),
              const SizedBox(height: 10.0,),
              ///description section
              Flexible(
                child: TextField(
                  controller: _descriptionController,
                  maxLines: 2,
                  minLines: 1,
                  maxLength: 50,
                  decoration: kInputFieldDecoration.copyWith(
                    labelText: 'Enter description',
                  ),
                ),
              ),
              const SizedBox(height: 10.0,),
              /// priority and date section
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///priority section
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Priority :'),
                      const SizedBox(width: 10.0,),
                      ///Drop down menu item
                      DropdownButton(
                        dropdownColor: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        items: const [
                          DropdownMenuItem(
                            value: 2,
                            child: Text('low'),
                          ),
                          DropdownMenuItem(
                            value: 1,
                            child: Text('High'),
                          )
                        ],
                        onChanged: (value){
                          setState(() {
                            _priority = value!;
                          });
                        },
                        value: _priority,
                        icon: const Icon(Icons.arrow_drop_down,color: Colors.black,),
                      )
                    ],
                  ),
                  ///Date text Field
                  SizedBox(
                    width: 170,
                    child:TextField(
                      onTap: ()=>selectDate(context),
                      controller: _dateController,
                      decoration: kInputFieldDecoration.copyWith(
                          labelText: 'Due Date',
                          prefixIcon: const Icon(Icons.date_range),
                          contentPadding: const EdgeInsets.all(0)
                      ),
                      readOnly: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0,),
              ///buttons
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ///submit button
                  TextButton(
                    onPressed: () {
                      ///check if all fields are filled.
                      ///as instance is passed no need to call another function
                      ///directly change value of instance and call a notifier to alert ui changes
                      if(_descriptionController.text.isNotEmpty && _titleController.text.isNotEmpty && _dateController.text.isNotEmpty){
                        todo.title  = _titleController.text;
                        todo.description = _descriptionController.text;
                        todo.dueDate  = _dateController.text;
                        todo.priority = _priority;
                        Provider.of<TodoData>(context,listen: false).notifyEditedTask();
                        Navigator.pop(context);
                        _titleController.clear();
                        _descriptionController.clear();
                        _dateController.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Task edited'))
                        );
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('All fields are required'))
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)
                      )
                    ),
                    child: const Text(
                      'Edit task',
                      style: kWhiteText,
                    ),
                  ),
                  /// clear section button
                  TextButton(
                    onPressed: () {
                      _titleController.clear();
                      _descriptionController.clear();
                      _dateController.clear();
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        )
                    ),
                    child: const Text(
                      'Clear section',
                      style: kWhiteText,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}



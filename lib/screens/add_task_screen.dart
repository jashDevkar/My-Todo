import 'package:flutter/material.dart';
import 'package:my_todo/constants/styles.dart';
import 'package:my_todo/database/todo_database.dart';
import 'package:provider/provider.dart';


///add task screen will collect all the information and on submit button it will call
///add task function of todo_dataBase class

TextEditingController _dateController = TextEditingController();
class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();


  int _priority = 2;

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
            'Add task',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
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
                        labelText: 'Date',
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
                      ///check if all fields are present or not
                      ///if not snow snack bar
                      ///else call addTask function and pop the navigator

                      if(_descriptionController.text.isNotEmpty && _titleController.text.isNotEmpty && _dateController.text.isNotEmpty){
                        Provider.of<TodoData>(context,listen: false).addData(
                            title: _titleController.text,
                            description: _descriptionController.text,
                            priority: _priority,
                            dueDate: _dateController.text
                        );
                        _titleController.clear();
                        _descriptionController.clear();
                        _dateController.clear();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Task added'))
                        );
                        Navigator.pop(context);
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('All fields are required'))
                        );
                      }
                    },
                    style: kSubmitButtonStyle.copyWith(
                        backgroundColor: const MaterialStatePropertyAll<Color>(
                            Colors.green)),
                    child: const Text(
                      'Add task',
                      style: kWhiteText,
                    ),
                  ),
                  /// clear section button
                  TextButton(
                    ///this will clear all fields of text field
                    onPressed: () {
                      _titleController.clear();
                      _descriptionController.clear();
                      _dateController.clear();
                    },
                    style: kSubmitButtonStyle.copyWith(
                        backgroundColor: const MaterialStatePropertyAll<Color>(Colors.red),
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

///date selector
Future<void> selectDate(context)async{
  DateTime? date = await showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime(2100));
  if(date  != null){
    _dateController.text = date.toString().split(" ")[0];
  }

}

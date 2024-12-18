import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_todo/database/todo_database.dart';
import 'package:my_todo/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main()async {
  await Hive.initFlutter();
  await Hive.openBox('myBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ///wrapping whole app in provider state management
    return ChangeNotifierProvider(
      create: (context)=>TodoData(),
      child: const MaterialApp(
        debugShowCheckedModeBanner:false,
        ///spliting app into 2 sections
        ///namely task header and task list
        ///task header containes information of total tasks
        ///task list will build tasks list
        ///This 2 sections are stored in home screen
        home: HomeScreen(),
        ),
    );
  }
}






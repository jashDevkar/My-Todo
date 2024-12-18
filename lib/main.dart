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
    return ChangeNotifierProvider(
      create: (context)=>TodoData(),
      child: const MaterialApp(
        debugShowCheckedModeBanner:false,
        home: HomeScreen(),
        ),
    );
  }
}






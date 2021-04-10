import 'package:flutter/material.dart';
import 'package:local_lancer/views/home.dart';
import 'package:local_lancer/views/taskjob.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LocalLancer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      //home: Home(),
      routes: {
        '/': (BuildContext context)=>Home(),
        '/taskjob': (BuildContext context)=>Taskjob()
      },
    );
  }
}
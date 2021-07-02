import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/util/firebase_service.dart';
import 'package:notes_app/util/get_controller.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: InkWell(
          child: Container(
            height: 50,
            width: 200,
            color: Colors.pink,
            child: Center(
              child: Text("Вход через Google",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20),)
                )
                ),
          onTap: () {
            FirebaseService().signInwithGoogle();
          },
        ),
      ),
    );
  }
}
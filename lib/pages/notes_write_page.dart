import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/util/get_controller.dart';

class NotesWritingPage extends StatefulWidget with WidgetsBindingObserver{
  const NotesWritingPage({ Key? key }) : super(key: key);

  @override
  _NotesWritingPageState createState() => _NotesWritingPageState();
}

class _NotesWritingPageState extends State<NotesWritingPage> {

  final myController = TextEditingController();
  final firestoreInstance = FirebaseFirestore.instance;
  final GetController controller = Get.find();


    @override
    void dispose() {
    myController.dispose();
    super.dispose();
  }


  void closeAppCallBack(List list) {
    FirebaseFirestore.instance
        .collection('notes')
        .doc("notes")
        .update({
      "notes": list.map((e) => {"notes": myController.text}).toList()
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: TextField(
          controller: myController,
          decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Write a note'
      ),
      ),
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: ()
        async {
          controller.createNote(myController);
          Navigator.of(context).pop();
                },
        child: Icon(Icons.send),
      ),
      ),
    );
  }
}
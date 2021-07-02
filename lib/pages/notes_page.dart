import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/util/firebase_service.dart';
import 'package:notes_app/util/get_controller.dart';
import 'package:notes_app/widgets/note_block.dart';

import 'notes_write_page.dart';

class NotesPage extends StatefulWidget with WidgetsBindingObserver{
  const NotesPage({ Key? key }) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> with WidgetsBindingObserver {

  final GetController controller = Get.put(GetController());

   bool? _isInBackground = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (_isInBackground = state == AppLifecycleState.inactive ||
       state == AppLifecycleState.detached) {
      controller.close();
    }
    
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GetController());
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Obx(
            () => ( 
              SingleChildScrollView(
            child: Column(
              children: controller.notesList
                  .map((element) => Center(
                        child: notesBlock(element),
                      ))
                  .toList(),
            ),
          )
          ),
        ),
        ),
         floatingActionButton: FloatingActionButton(
          onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => new NotesWritingPage()));
                        FirebaseService().getNotesList();
                  },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
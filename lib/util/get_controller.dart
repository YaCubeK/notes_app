import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:notes_app/util/firebase_service.dart';

class GetController extends GetxController {
   final bd = GetStorage();
   var notesList = [].obs;

  @override
  void onInit() {
    initNotesList();
    super.onInit();
  }

  Future<void> initNotesList() async {
    List list = await FirebaseService().getNotesList();
    notesList = list.obs;
    update();
  }
  
  void createNote(TextEditingController myController) async {
    notesList.add(myController.text);
    bd.writeInMemory('notes', notesList.map((element) => element).toList());
    bd.save();
    update();
  }

  void close() {
    FirebaseService().closeApp(notesList);
  }
}
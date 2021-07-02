import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/pages/home_page.dart';
import 'package:notes_app/pages/notes_page.dart';

class Wrapper extends StatelessWidget with WidgetsBindingObserver{
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

      @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print("app in resumed");
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        break;
    }
    super.didChangeAppLifecycleState(state);
}
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return NotesPage();
                }
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Container(
                      color: Colors.blue,
                    ),
                  );
                }
                return MyHomePage(title: '',);
              });
        });
  }
}
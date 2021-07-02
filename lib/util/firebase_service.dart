import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final firestoreInstance = FirebaseFirestore.instance;

  Future<String?> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  Future getNotesList() async {
      var notesList = await firestoreInstance.collection("notes").doc("notes").get().then((value){
      return value.data()!['notes'];
      });
      print(notesList);
      return notesList;
  }

  void closeApp(List notesList) {
    FirebaseFirestore.instance
        .collection('notes')
        .doc('notes')
        .update({
      "notes": notesList
    });
  }
  
}
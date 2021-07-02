import 'package:flutter/material.dart';

Widget notesBlock(String noteText) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 50,
      width: 100,
      color: Colors.amber,
      margin: EdgeInsets.all(8.0),
      child: Center(child: Text("$noteText"))),
  );
}
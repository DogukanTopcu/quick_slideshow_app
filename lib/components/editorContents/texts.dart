import 'package:flutter/material.dart';

class Texts extends StatefulWidget {
  const Texts({super.key});

  @override
  State<Texts> createState() => _TextsState();
}

class _TextsState extends State<Texts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 98,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.text_fields),
          Text("Add Text"),
        ],
      ),
    );
  }
}

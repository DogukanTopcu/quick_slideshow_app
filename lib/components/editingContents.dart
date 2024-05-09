import 'package:flutter/material.dart';
import 'package:quick_slideshow/components/editorContents/images.dart';
import 'package:quick_slideshow/components/editorContents/music.dart';
import 'package:quick_slideshow/components/editorContents/texts.dart';

class EditingContents extends StatefulWidget {
  const EditingContents({super.key});

  @override
  State<EditingContents> createState() => _EditingContentsState();
}

class _EditingContentsState extends State<EditingContents> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: const <Widget>[
          Images(),
          Music(),
          Texts(),
        ],
      ),
    );
  }
}

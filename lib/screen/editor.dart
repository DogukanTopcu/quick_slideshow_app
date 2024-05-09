import 'package:flutter/material.dart';
import 'package:quick_slideshow/components/addButtons.dart';
import 'package:quick_slideshow/components/controlPanel.dart';
import 'package:quick_slideshow/components/editingContents.dart';
import 'package:quick_slideshow/components/editorAppBarTitle.dart';
import 'package:quick_slideshow/components/editorArea.dart';

class Editor extends StatefulWidget {
  const Editor({super.key});

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent,
            title: const EditorAppBarTitle()),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            screen(context),
            playButtons(context),
            editArea(context),
            buttons(context)
          ],
        ));
  }

  Widget screen(BuildContext context) {
    context = this.context;
    return const Expanded(flex: 7, child: EditorArea());
  }

  Widget playButtons(BuildContext context) {
    context = this.context;
    return const Expanded(
      flex: 1,
      child: ControlPanel(),
    );
  }

  Widget editArea(BuildContext context) {
    context = this.context;
    return const Expanded(
      flex: 3,
      child: EditingContents(),
    );
  }

  Widget buttons(BuildContext context) {
    context = this.context;
    return const Expanded(
      flex: 1,
      child: AddButtons(),
    );
  }
}

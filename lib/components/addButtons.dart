import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_slideshow/providers/editorProvider.dart';

class AddButtons extends StatefulWidget {
  const AddButtons({super.key});

  @override
  State<AddButtons> createState() => _AddButtonsState();
}

class _AddButtonsState extends State<AddButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(Icons.add_a_photo, size: 32),
            onPressed: () {
              Provider.of<EditorProvider>(context, listen: false).getImages();
            },
          ),
          IconButton(
            icon: const Icon(Icons.music_video, size: 32),
            onPressed: () async {
              // final result = await
            },
          ),
          IconButton(
            icon: const Icon(Icons.import_export, size: 32),
            onPressed: () async {
              // final result = await
            },
          ),
        ],
      )),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_slideshow/home.dart';

class Editor extends StatefulWidget {
  const Editor({super.key});

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  String documentName = "Slideshow";

  final ImagePicker ip = ImagePicker();
  List<XFile> imageFileList = [];

  int selectedImageIndex = -1;

  void _selectImages() async {
    final List<XFile> selectedImages = await ip.pickMultiImage();

    if (selectedImages.isNotEmpty) {
      imageFileList.addAll(selectedImages);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage()));
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      documentName = "New Slideshow";
                    });
                  },
                  child: Text(
                    documentName,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              ],
            )),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 6,
              child: Container(
                color: Colors.red,
                child: const Center(
                  child: Text("data"),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.green,
                child: const Center(
                  child: Text("data"),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.blue,
                child: Center(
                    child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: imageFileList.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == imageFileList.length - 1) {
                      return Container(
                        margin: const EdgeInsets.all(8),
                        child: Image.file(
                          File(imageFileList[index].path),
                          fit: BoxFit.cover,
                        ),
                      );
                    }
                    return Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8),
                            child: Image.file(
                              File(imageFileList[index].path),
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Icon(Icons.arrow_right_alt_outlined),
                        ]);
                  },
                )),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.orange,
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      child: const Text("Add Photo"),
                      onPressed: () {
                        _selectImages();
                      },
                    ),
                    ElevatedButton(
                      child: const Text("Add Music"),
                      onPressed: () async {
                        // final result = await
                      },
                    ),
                    ElevatedButton(
                      child: const Text("Export"),
                      onPressed: () async {
                        // final result = await
                      },
                    ),
                  ],
                )),
              ),
            ),
          ],
        ));
  }
}

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

  bool isPlaying = false;

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
                child: Container(
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Bum"),
                    ],
                  ),
                ),
              ),
            ),
            // Slideshow play buttons
            Expanded(
              flex: 1,
              child: Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_left,
                            color: Colors.black,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.keyboard_double_arrow_left,
                                color: Colors.black,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                !isPlaying ? Icons.play_arrow : Icons.pause,
                                color: Colors.black,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.keyboard_double_arrow_right,
                                color: Colors.black,
                              )),
                        ],
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_right,
                            color: Colors.black,
                          )),
                    ],
                  )),
            ),
            // Editor: Image, music and text area
            Expanded(
              flex: 4,
              child: Container(
                alignment: Alignment.centerLeft,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Container(
                        color: Colors.black,
                        height: 144,
                        child: imageFileList.isEmpty
                            ? const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.image),
                                  Text("Add Photo"),
                                ],
                              )
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: imageFileList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index == imageFileList.length - 1) {
                                    return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 98,
                                          height: 98,
                                          margin: const EdgeInsets.all(8),
                                          child: Image.file(
                                            File(imageFileList[index].path),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  return Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 98,
                                          height: 98,
                                          margin: const EdgeInsets.all(8),
                                          child: Image.file(
                                            File(imageFileList[index].path),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const Icon(
                                            Icons.keyboard_double_arrow_right),
                                      ]);
                                },
                              )),
                    Container(
                      color: Colors.black54,
                      height: 98,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.music_note),
                          Text("Add Music"),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.black,
                      height: 98,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.text_fields),
                          Text("Add Text"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
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

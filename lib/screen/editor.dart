import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_slideshow/home.dart';

// import 'package:flutter_animate/flutter_animate.dart';

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

    setState(() {
      selectedImageIndex = 0;
    });
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
            screen(context),
            playButtons(context),
            editArea(context),
            buttons(context)
          ],
        ));
  }

  void _showsnackbar(String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 1),
        ),
      );

  Widget screen(BuildContext context) {
    context = this.context;
    return Expanded(
        flex: 7,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              color: Colors.white54,
            ),
            screen_9_16(context),
          ],
        ));
  }

  Widget screen_1_1(BuildContext context) {
    context = this.context;
    return Container(
      color: Colors.black,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      child: selectedImageIndex != -1
          ? Image.file(
              File(imageFileList[selectedImageIndex].path),
              fit: BoxFit.cover,
            )
          : null,
    );
  }

  Widget screen_16_9(BuildContext context) {
    context = this.context;
    return FractionallySizedBox(
      heightFactor: 1.0,
      widthFactor: 0.6,
      child: Container(
        color: Colors.black,
        child: selectedImageIndex != -1
            ? Image.file(
                File(imageFileList[selectedImageIndex].path),
                fit: BoxFit.cover,
              )
            : null,
      ),
    );
  }

  Widget screen_9_16(BuildContext context) {
    context = this.context;
    return FractionallySizedBox(
      heightFactor: 1.0,
      widthFactor: 0.6,
      child: Container(
        color: Colors.black,
        child: selectedImageIndex != -1
            ? Image.file(
                File(imageFileList[selectedImageIndex].path),
                fit: BoxFit.cover,
              )
            : null,
      ),
    );
  }

  Widget screen_4_3(BuildContext context) {
    context = this.context;
    return FractionallySizedBox(
      heightFactor: 1.0,
      widthFactor: 0.6,
      child: Container(
        color: Colors.black,
        child: selectedImageIndex != -1
            ? Image.file(
                File(imageFileList[selectedImageIndex].path),
                fit: BoxFit.cover,
              )
            : null,
      ),
    );
  }

  Widget screen_3_4(BuildContext context) {
    context = this.context;
    return FractionallySizedBox(
      heightFactor: 1.0,
      widthFactor: 0.6,
      child: Container(
        color: Colors.black,
        child: selectedImageIndex != -1
            ? Image.file(
                File(imageFileList[selectedImageIndex].path),
                fit: BoxFit.cover,
              )
            : null,
      ),
    );
  }

  Widget playButtons(BuildContext context) {
    context = this.context;
    return Expanded(
      flex: 1,
      child: Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: imageFileList.isEmpty
                      ? null
                      : selectedImageIndex != 0
                          ? () {
                              setState(() {
                                selectedImageIndex--;
                              });
                            }
                          : null,
                  icon: Icon(
                    Icons.keyboard_arrow_left_outlined,
                    color:
                        imageFileList.isEmpty ? Colors.black26 : Colors.black,
                    size: 36,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: !isPlaying ? null : () {},
                      icon: Icon(
                        Icons.keyboard_double_arrow_left,
                        color: isPlaying ? Colors.black : Colors.black26,
                        size: 36,
                      )),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          isPlaying = !isPlaying;
                        });
                      },
                      icon: Icon(
                        !isPlaying ? Icons.play_arrow : Icons.pause,
                        color: Colors.deepPurpleAccent,
                        size: 36,
                      )),
                  IconButton(
                      onPressed: !isPlaying ? null : () {},
                      icon: Icon(
                        Icons.keyboard_double_arrow_right,
                        color: isPlaying ? Colors.black : Colors.black26,
                        size: 36,
                      )),
                ],
              ),
              IconButton(
                  onPressed: imageFileList.isEmpty
                      ? null
                      : selectedImageIndex != imageFileList.length - 1
                          ? () {
                              setState(() {
                                selectedImageIndex++;
                              });
                            }
                          : null,
                  icon: Icon(
                    Icons.keyboard_arrow_right_outlined,
                    color:
                        imageFileList.isEmpty ? Colors.black26 : Colors.black,
                    size: 36,
                  )),
            ],
          )),
    );
  }

  Widget editArea(BuildContext context) {
    context = this.context;
    return Expanded(
      flex: 3,
      child: Container(
        alignment: Alignment.centerLeft,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
                color: Colors.black,
                height: 184,
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    width: 110,
                                    height: 110,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 5),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedImageIndex = index;
                                        });
                                      },
                                      child: Image.file(
                                        File(imageFileList[index].path),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ],
                            );
                          }
                          return Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    width: 110,
                                    height: 110,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 5),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedImageIndex = index;
                                        });
                                      },
                                      child: Image.file(
                                        File(imageFileList[index].path),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                const Icon(Icons.keyboard_double_arrow_right),
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
    );
  }

  Widget buttons(BuildContext context) {
    context = this.context;
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.black12,
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.add_a_photo, size: 32),
              onPressed: () {
                _selectImages();
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
      ),
    );
  }
}

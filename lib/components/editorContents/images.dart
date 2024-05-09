import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quick_slideshow/providers/editorProvider.dart';

class Images extends StatefulWidget {
  const Images({super.key});

  @override
  State<Images> createState() => _ImagesState();
}

class _ImagesState extends State<Images> {
  bool isPlaying = false;
  List<XFile> imageFileList = [];
  int selectedImageIndex = -1;

  @override
  Widget build(BuildContext context) {
    isPlaying = Provider.of<EditorProvider>(context).isPlaying;
    imageFileList = Provider.of<EditorProvider>(context).imageFileList;
    selectedImageIndex =
        Provider.of<EditorProvider>(context).selectedImageIndex;

    return Container(
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
                        GestureDetector(
                          onTap: () {
                            Provider.of<EditorProvider>(context, listen: false)
                                .changeSelectedImageIndex(index);
                          },
                          child: Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(imageFileList[index].path),
                                  fit: BoxFit.cover,
                                ),
                              )),
                        ),
                      ],
                    );
                  }
                  return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Provider.of<EditorProvider>(context, listen: false)
                                .changeSelectedImageIndex(index);
                          },
                          child: Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  File(imageFileList[index].path),
                                  fit: BoxFit.cover,
                                ),
                              )),
                        ),
                        const Icon(Icons.keyboard_double_arrow_right),
                      ]);
                },
              ));
  }
}

import 'dart:typed_data';

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quick_slideshow/components/imageEditor/singleImageEditor.dart';
import 'package:quick_slideshow/providers/editorProvider.dart';
import 'package:image_editor_plus/options.dart' as o;

class Images extends StatefulWidget {
  const Images({super.key});

  @override
  State<Images> createState() => _ImagesState();
}

class _ImagesState extends State<Images> {
  bool isPlaying = false;
  List<Uint8List> imageFileList = [];
  int selectedImageIndex = -1;

  @override
  Widget build(BuildContext context) {
    isPlaying = Provider.of<EditorProvider>(context).isPlaying;
    imageFileList =
        Provider.of<EditorProvider>(context).slideshowData.imageFileList;
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
                    if (index == selectedImageIndex) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              var editedImage = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SingleImageEditor(
                                    image: imageFileList[index],
                                    savePath: "",
                                    imagePickerOption:
                                        const o.ImagePickerOption(),
                                    outputFormat: o.OutputFormat.jpeg,
                                    cropOption: const o.CropOption(),
                                    blurOption: const o.BlurOption(),
                                    brushOption: const o.BrushOption(),
                                    emojiOption: const o.EmojiOption(),
                                    filtersOption: const o.FiltersOption(),
                                    flipOption: const o.FlipOption(),
                                    rotateOption: const o.RotateOption(),
                                    textOption: const o.TextOption(),
                                  ),
                                ),
                              );
                              Provider.of<EditorProvider>(context,
                                      listen: false)
                                  .updateImage(editedImage, index);
                            },
                            child: Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.deepPurpleAccent, width: 5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Stack(
                                alignment: Alignment.center,
                                fit: StackFit.expand,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.memory(
                                      imageFileList[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.black54),
                                      padding: const EdgeInsets.all(8),
                                      child: const Text(
                                        'Tap to edit',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: const BoxDecoration(
                                        color: Colors.deepPurpleAccent,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Provider.of<EditorProvider>(context,
                                      listen: false)
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
                                  child: Image.memory(
                                    imageFileList[index],
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          ),
                        ],
                      );
                    }
                  } else {
                    if (index == selectedImageIndex) {
                      return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                var editedImage = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SingleImageEditor(
                                      image: imageFileList[index],
                                      savePath: "",
                                      imagePickerOption:
                                          const o.ImagePickerOption(),
                                      outputFormat: o.OutputFormat.jpeg,
                                      cropOption: const o.CropOption(),
                                      blurOption: const o.BlurOption(),
                                      brushOption: const o.BrushOption(),
                                      emojiOption: const o.EmojiOption(),
                                      filtersOption: const o.FiltersOption(),
                                      flipOption: const o.FlipOption(),
                                      rotateOption: const o.RotateOption(),
                                      textOption: const o.TextOption(),
                                    ),
                                  ),
                                );
                                Provider.of<EditorProvider>(context,
                                        listen: false)
                                    .updateImage(editedImage, index);
                              },
                              child: Container(
                                width: 110,
                                height: 110,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.deepPurpleAccent, width: 5),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Stack(
                                  alignment: Alignment.center,
                                  fit: StackFit.expand,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.memory(
                                        imageFileList[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.black54),
                                        padding: const EdgeInsets.all(8),
                                        child: const Text(
                                          'Tap to edit',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                          color: Colors.deepPurpleAccent,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Icon(Icons.keyboard_double_arrow_right),
                          ]);
                    } else {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Provider.of<EditorProvider>(context,
                                      listen: false)
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
                                  child: Image.memory(
                                    imageFileList[index],
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          ),
                          const Icon(Icons.keyboard_double_arrow_right),
                        ],
                      );
                    }
                  }
                },
              ));
  }
}

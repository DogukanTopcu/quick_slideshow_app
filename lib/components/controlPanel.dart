import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_slideshow/providers/editorProvider.dart';

class ControlPanel extends StatefulWidget {
  const ControlPanel({super.key});

  @override
  State<ControlPanel> createState() => _ControlState();
}

class _ControlState extends State<ControlPanel> {
  bool isPlaying = false;
  late List<Uint8List> imageFileList;
  int selectedImageIndex = -1;

  @override
  Widget build(BuildContext context) {
    isPlaying = Provider.of<EditorProvider>(context).isPlaying;
    imageFileList = Provider.of<EditorProvider>(context).imageFileList;
    selectedImageIndex =
        Provider.of<EditorProvider>(context).selectedImageIndex;

    EditorProvider editorProviderFunc =
        Provider.of<EditorProvider>(context, listen: false);

    return Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: imageFileList.isEmpty
                    ? null
                    : selectedImageIndex != 0
                        ? () {
                            Provider.of<EditorProvider>(context, listen: false)
                                .changeSelectedImageIndex(
                                    selectedImageIndex - 1);
                          }
                        : null,
                icon: Icon(
                  Icons.keyboard_arrow_left_outlined,
                  color: imageFileList.isEmpty
                      ? Colors.black26
                      : !isPlaying
                          ? Colors.black
                          : Colors.black26,
                  size: 36,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: isPlaying
                        ? null
                        : imageFileList.isNotEmpty
                            ? () {
                                editorProviderFunc.changeSelectedImageIndex(0);
                              }
                            : null,
                    icon: Icon(
                      Icons.keyboard_double_arrow_left,
                      color: !isPlaying
                          ? imageFileList.isNotEmpty
                              ? Colors.black
                              : Colors.black26
                          : Colors.black26,
                      size: 36,
                    )),
                IconButton(
                    onPressed: imageFileList.isNotEmpty
                        ? () {
                            Provider.of<EditorProvider>(context, listen: false)
                                .changeIsPlaying();

                            if (isPlaying) {
                              Provider.of<EditorProvider>(context,
                                      listen: false)
                                  .stopTimer();
                            } else {
                              Provider.of<EditorProvider>(context,
                                      listen: false)
                                  .startTimer();
                            }
                          }
                        : null,
                    icon: Icon(
                      !isPlaying ? Icons.play_arrow : Icons.pause,
                      color: imageFileList.isNotEmpty
                          ? Colors.deepPurpleAccent
                          : Colors.black26,
                      size: 36,
                    )),
                IconButton(
                    onPressed: isPlaying
                        ? null
                        : imageFileList.isNotEmpty
                            ? () {
                                editorProviderFunc.changeSelectedImageIndex(
                                    imageFileList.length - 1);
                              }
                            : null,
                    icon: Icon(
                      Icons.keyboard_double_arrow_right,
                      color: !isPlaying
                          ? imageFileList.isNotEmpty
                              ? Colors.black
                              : Colors.black26
                          : Colors.black26,
                      size: 36,
                    )),
              ],
            ),
            IconButton(
                onPressed: imageFileList.isEmpty
                    ? null
                    : selectedImageIndex != imageFileList.length - 1
                        ? () {
                            Provider.of<EditorProvider>(context, listen: false)
                                .changeSelectedImageIndex(
                                    selectedImageIndex + 1);
                          }
                        : null,
                icon: Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: imageFileList.isEmpty
                      ? Colors.black26
                      : !isPlaying
                          ? Colors.black
                          : Colors.black26,
                  size: 36,
                )),
          ],
        ));
  }
}

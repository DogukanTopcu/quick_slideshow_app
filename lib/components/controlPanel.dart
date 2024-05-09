import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quick_slideshow/providers/editorProvider.dart';

class ControlPanel extends StatefulWidget {
  const ControlPanel({super.key});

  @override
  State<ControlPanel> createState() => _ControlState();
}

class _ControlState extends State<ControlPanel> {
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
                  color: imageFileList.isEmpty ? Colors.black26 : Colors.black,
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
                      Provider.of<EditorProvider>(context, listen: false)
                          .changeIsPlaying();
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
                            Provider.of<EditorProvider>(context, listen: false)
                                .changeSelectedImageIndex(
                                    selectedImageIndex + 1);
                          }
                        : null,
                icon: Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: imageFileList.isEmpty ? Colors.black26 : Colors.black,
                  size: 36,
                )),
          ],
        ));
  }
}

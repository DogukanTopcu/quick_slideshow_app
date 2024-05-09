import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quick_slideshow/components/controlPanel.dart';
import 'package:quick_slideshow/components/editingContents.dart';
import 'package:quick_slideshow/components/editorArea.dart';
import 'package:quick_slideshow/home.dart';
import 'package:quick_slideshow/providers/editorProvider.dart';
import 'package:quick_slideshow/screen/settings.dart';

import 'dart:math' as math;

// import 'package:flutter_animate/flutter_animate.dart';

class Editor extends StatefulWidget {
  const Editor({super.key});

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  // Attributes for image picker
  final ImagePicker ip = ImagePicker();
  List<XFile> imageFileList = [];
  int selectedImageIndex = -1;

  // Attributes used and can changed in editor screen
  String documentName = "Slideshow";
  final TextEditingController _textEditingController = TextEditingController();
  bool isPlaying = false;

  // Attributes used but cannot changed in editor screen, it can be changed with settings screen
  int screenFormat = 0;

  double _imageScale = 1;
  List<Widget> textList = [];

  Matrix4 _matrix = Matrix4(
    1, 0, 0, 0, //
    0, 1, 0, 0,
    0, 0, 1, 0,
    0, 0, 0, 1,
  );

  double _baseScaleFactor = 1.0;
  double _scaleFactor = 1.0;

  double _baseAngleFactor = 0;
  double _angleFactor = 0;

  @override
  Widget build(BuildContext context) {
    documentName = Provider.of<EditorProvider>(context).documentName;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Provider.of<EditorProvider>(context, listen: false)
                        .initState();
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
                    _openPanel();
                  },
                  child: Text(
                    documentName,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Settings()));
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
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

  Widget screen(BuildContext context) {
    context = this.context;
    return Expanded(
        flex: 7,
        child: EditorArea(
            screenFormat: screenFormat,
            imageFileList: imageFileList,
            selectedImageIndex: selectedImageIndex));
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
      ),
    );
  }

  // Functions:
  void _openPanel() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(labelText: 'Yeni Metin'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      if (_textEditingController.text.isEmpty) {
                        _showsnackbar("The file name cannot be blank");
                      } else {
                        Provider.of<EditorProvider>(context, listen: false)
                            .changeDocumentName(_textEditingController.text);
                      }
                    },
                    child: const Text('Onayla'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('İptal Et'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showsnackbar(String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 1),
        ),
      );

  Widget screen_1_1(BuildContext context) {
    context = this.context;
    return LayoutBuilder(builder: (context, constraints) {
      double size = constraints.maxWidth < constraints.maxHeight
          ? constraints.maxWidth
          : constraints.maxHeight;
      return Container(
        color: Colors.black,
        width: size,
        height: size,
        child: Transform(
          transform: _matrix,
          alignment: Alignment.center,
          child: GestureDetector(
            onScaleStart: (details) {
              setState(() {
                _baseScaleFactor = _scaleFactor;
                _baseAngleFactor = _angleFactor;
              });
            },
            onScaleUpdate: (details) {
              setState(() {
                _scaleFactor = _baseScaleFactor * details.scale;
                _angleFactor = _baseAngleFactor + details.rotation;

                var angleMatrix = Matrix4.identity();
                angleMatrix[0] = angleMatrix[5] = math.cos(_angleFactor);
                angleMatrix[1] = math.sin(_angleFactor);
                angleMatrix[4] = -math.sin(_angleFactor);

                var scaleMatrix = Matrix4.identity();
                scaleMatrix[0] = scaleMatrix[5] = _scaleFactor;

                _matrix = angleMatrix * scaleMatrix;
              });
            },
            child: Container(
              height: size,
              width: size,
              color: Colors.red,
            ),
          ),
        ),
      );
    });
  }

  Widget dragAndDroppableArea(BuildContext context, int size) {
    size = size;
    context = context;
    return Stack(
      children: [
        Positioned(
          left: 0,
          top: 0,
          child: GestureDetector(
            onScaleUpdate: (details) {
              setState(() {
                _imageScale = details.scale;
              });
            },
            child: Image.file(
              File(imageFileList[selectedImageIndex].path),
              width: size * _imageScale,
              height: size * _imageScale,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}

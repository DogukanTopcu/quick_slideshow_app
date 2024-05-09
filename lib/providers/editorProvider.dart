import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class EditorProvider with ChangeNotifier {
  int id = 0;
  bool isPlaying = false;
  List<XFile> imageFileList = [];
  int selectedImageIndex = -1;
  String documentName = "Slideshow";
  int screenFormat = 0;
  final ImagePicker ip = ImagePicker();

  void initState() {
    id = 0;
    isPlaying = false;
    imageFileList = [];
    selectedImageIndex = -1;
    documentName = "Slideshow";
    screenFormat = 0;
  }

  void getImages() async {
    final List<XFile> selectedImages = await ip.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList.addAll(selectedImages);
    }

    selectedImageIndex = imageFileList.length - 1;

    notifyListeners();
  }

  void changeScreenFormat(int format) {
    screenFormat = format;
    notifyListeners();
  }

  void changeSelectedImageIndex(int index) {
    selectedImageIndex = index;
    notifyListeners();
  }

  void changeIsPlaying() {
    isPlaying = !isPlaying;
    notifyListeners();
  }

  void changeDocumentName(String dName) {
    documentName = dName;
    notifyListeners();
  }
}

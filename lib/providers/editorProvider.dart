import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:quick_slideshow/models/image_model.dart';

class EditorProvider with ChangeNotifier {
  int id = 0;
  bool isPlaying = false;

  List<Uint8List> imageFileList = [];
  List<ImageData> imgFileList = [];

  List<XFile> audioFileList = [];
  int selectedImageIndex = -1;
  String documentName = "Slideshow";
  int screenFormat = 0;
  final ImagePicker ip = ImagePicker();

  // Timer
  Timer? _timer;
  double timeElapsed = 0;
  int _start = 0;
  bool _isRunning = false;
  int get time => _start;
  bool get isRunning => _isRunning;

  int secondsPerImage = 3;
  int stopTime = 0;

  void initState() {
    id = 0;
    isPlaying = false;

    imageFileList = [];
    imgFileList = [];

    audioFileList = [];
    selectedImageIndex = -1;
    documentName = "Slideshow";
    screenFormat = 0;
  }

  Future<void> getImages() async {
    final List<XFile> selectedImages = await ip.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      for (XFile element in selectedImages) {
        imgFileList.add(ImageData(element, 2.0, 1, 1));

        Uint8List bytes = await element.readAsBytes();
        imageFileList.add(bytes);
      }
      // imageFileList.addAll(selectedImages);
    }

    selectedImageIndex = imgFileList.length - 1;
    stopTime = secondsPerImage * imageFileList.length;

    notifyListeners();
  }

  void getAudios() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ["mp3", "aac", "wav"]);
    if (result != null) {
      audioFileList =
          result.paths.map((path) => File(path!)).cast<XFile>().toList();
    } else {
      // User canceled the picker
    }

    notifyListeners();
  }

  void changeScreenFormat(int format) {
    screenFormat = format;
    notifyListeners();
  }

  void changeSelectedImageIndex(int index) {
    selectedImageIndex = index;
    isPlaying = false;
    if (_timer != null) {
      _timer!.cancel();
    }
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

  void updateImage(Uint8List updatedImage, int index) {
    imageFileList[index] = updatedImage;
    notifyListeners();
  }

  Future<void> executeSlideshow() async {}

  // Timer ************************************************************
  void _tick(Timer timer) {
    if (_start > 0) {
      _start--;
      notifyListeners();
    } else {
      timeElapsed += 1;

      if (timeElapsed == stopTime) {
        _timer!.cancel();
        isPlaying = false;
        timeElapsed = 0;
        selectedImageIndex = 0;
        notifyListeners();
        return;
      }

      selectedImageIndex = (timeElapsed / secondsPerImage).toInt();
      _isRunning = false;
      notifyListeners();
    }
  }

  void startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    timeElapsed = (selectedImageIndex * secondsPerImage).toDouble();
    _timer = Timer.periodic(const Duration(seconds: 1), _tick);
    _isRunning = true;
    notifyListeners();
  }

  void stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _isRunning = false;
      notifyListeners();
    }
  }

  void resetTimer() {
    if (_timer != null) {
      _timer!.cancel();
      timeElapsed = 0;
    }
    _start = 0;
    timeElapsed = 0;
    selectedImageIndex = 0;
    _isRunning = false;
    notifyListeners();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  void changeImageDuration(int imageDuration) {
    secondsPerImage = imageDuration;
    stopTime = secondsPerImage * imageFileList.length;
    notifyListeners();
  }
}

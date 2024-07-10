import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:quick_slideshow/data/dataStorage.dart';
import 'package:quick_slideshow/models/slideshowModel.dart';

class EditorProvider with ChangeNotifier {
  late SlideshowData slideshowData;
  bool isPlaying = false;
  int selectedImageIndex = -1;
  final ImagePicker ip = ImagePicker();

  // Timer
  Timer? _timer;
  double timeElapsed = 0;
  int _start = 0;
  bool _isRunning = false;
  int get time => _start;
  bool get isRunning => _isRunning;

  int stopTime = 0;

  void initState() {
    isPlaying = false;

    selectedImageIndex = -1;
  }

  void loadData(SlideshowData data) {
    slideshowData = data;

    isPlaying = false;
    selectedImageIndex = slideshowData.imageFileList.isEmpty ? -1 : 0;
    stopTime =
        slideshowData.imageFileList.length * slideshowData.secondsPerImage;
    timeElapsed = 0;
    _start = 0;
    _isRunning = false;

    notifyListeners();
  }

  Future<void> getImages() async {
    final List<XFile> selectedImages = await ip.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      for (XFile element in selectedImages) {
        Uint8List bytes = await element.readAsBytes();
        slideshowData.imageFileList.add(bytes);
      }
    }

    selectedImageIndex = slideshowData.imageFileList.length - 1;
    stopTime =
        slideshowData.secondsPerImage * slideshowData.imageFileList.length;

    await DataStorage.updateSlideshowData(slideshowData);

    notifyListeners();
  }

  void getAudios() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ["mp3", "aac", "wav"]);
    if (result != null) {
      slideshowData.audioFileList =
          result.paths.map((path) => File(path!)).cast<XFile>().toList();
    } else {
      // User canceled the picker
    }

    notifyListeners();
  }

  void changeScreenFormat(int format) async {
    slideshowData.screenFormat = format;
    await DataStorage.updateSlideshowData(slideshowData);
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

  Future<void> changeDocumentName(String dName) async {
    slideshowData.documentName = dName;
    await DataStorage.updateSlideshowData(slideshowData);
    notifyListeners();
  }

  void updateImage(Uint8List updatedImage, int index) async {
    slideshowData.imageFileList[index] = updatedImage;
    await DataStorage.updateSlideshowData(slideshowData);
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

      selectedImageIndex =
          (timeElapsed / slideshowData.secondsPerImage).toInt();
      _isRunning = false;
      notifyListeners();
    }
  }

  void startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    timeElapsed =
        (selectedImageIndex * slideshowData.secondsPerImage).toDouble();
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

  void changeImageDuration(int imageDuration) async {
    slideshowData.secondsPerImage = imageDuration;
    stopTime =
        slideshowData.secondsPerImage * slideshowData.imageFileList.length;

    await DataStorage.updateSlideshowData(slideshowData);
    notifyListeners();
  }
}

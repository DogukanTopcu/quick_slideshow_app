import 'package:flutter/material.dart';
import 'package:quick_slideshow/data/dataStorage.dart';
import 'package:quick_slideshow/models/slideshowModel.dart';

class HomeScreenProvider extends ChangeNotifier {
  List<SlideshowData> _slideshows = [];
  List<SlideshowData> get slideshows => _slideshows;

  int _selectedId = 0;
  int get selectedId => _selectedId;

  HomeScreenProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    _slideshows = await DataStorage.getSlideshowDataList();
    notifyListeners();
  }

  Future<void> loadData() async {
    _slideshows = await DataStorage.getSlideshowDataList();
    notifyListeners();
  }

  Future<SlideshowData> addEmptySlideshowData() async {
    SlideshowData slideshow = SlideshowData(
        id: DateTime.now().millisecondsSinceEpoch,
        imageFileList: [],
        audioFileList: [],
        documentName: "New Slideshow",
        screenFormat: 0,
        secondsPerImage: 3);

    await DataStorage.addSlideshowData(slideshow);
    await _loadData();
    notifyListeners();

    return slideshow;
  }

  Future<void> deleteSlideshowData(int id) async {
    await DataStorage.deleteSlideshowData(id);
    await _loadData();
    notifyListeners();
  }
}

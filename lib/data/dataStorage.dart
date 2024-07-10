import 'dart:convert';

import 'package:quick_slideshow/models/slideshowModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataStorage {
  static const String _slideshowDataListKey = 'slideshowDataList';

  static Future<void> saveSlideshowDataList(
      List<SlideshowData> dataList) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> stringList =
        dataList.map((data) => jsonEncode(data.toJson())).toList();
    await prefs.setStringList(_slideshowDataListKey, stringList);
  }

  static Future<List<SlideshowData>> getSlideshowDataList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? stringList = prefs.getStringList(_slideshowDataListKey);
    if (stringList != null) {
      return stringList
          .map((string) => SlideshowData.fromJson(jsonDecode(string)))
          .toList();
    }
    return [];
  }

  static Future<void> addSlideshowData(SlideshowData data) async {
    List<SlideshowData> dataList = await getSlideshowDataList();
    dataList.add(data);

    await saveSlideshowDataList(dataList);
  }

  static Future<void> updateSlideshowData(SlideshowData data) async {
    List<SlideshowData> dataList = await getSlideshowDataList();
    int index = dataList.indexWhere((item) => item.id == data.id);
    if (index != -1) {
      dataList[index] = data;
      await saveSlideshowDataList(dataList);
    }
  }

  static Future<void> deleteSlideshowData(int id) async {
    List<SlideshowData> dataList = await getSlideshowDataList();
    dataList.removeWhere((item) => item.id == id);
    await saveSlideshowDataList(dataList);
  }
}

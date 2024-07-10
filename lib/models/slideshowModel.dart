import 'dart:convert';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class SlideshowData {
  int id;
  List<Uint8List> imageFileList;
  List<XFile> audioFileList;
  String documentName;
  int screenFormat;
  int secondsPerImage;

  SlideshowData({
    required this.id,
    required this.imageFileList,
    required this.audioFileList,
    required this.documentName,
    required this.screenFormat,
    required this.secondsPerImage,
  });

  factory SlideshowData.fromJson(Map<String, dynamic> json) {
    return SlideshowData(
      id: json['id'],
      imageFileList: (json['imageFileList'] as List)
          .map((item) => base64Decode(item))
          .toList(),
      audioFileList:
          (json['audioFileList'] as List).map((item) => XFile(item)).toList(),
      documentName: json['documentName'],
      screenFormat: json['screenFormat'],
      secondsPerImage: json['secondsPerImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageFileList': imageFileList.map((item) => base64Encode(item)).toList(),
      'audioFileList': audioFileList.map((item) => item.path).toList(),
      'documentName': documentName,
      'screenFormat': screenFormat,
      'secondsPerImage': secondsPerImage,
    };
  }
}

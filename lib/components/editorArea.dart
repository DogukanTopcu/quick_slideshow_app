import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:quick_slideshow/providers/editorProvider.dart';

class EditorArea extends StatefulWidget {
  final int screenFormat;
  final int selectedImageIndex;
  final List<XFile> imageFileList;

  const EditorArea(
      {super.key,
      required this.screenFormat,
      required this.imageFileList,
      required this.selectedImageIndex});

  @override
  State<EditorArea> createState() => _EditorAreaState();
}

class _EditorAreaState extends State<EditorArea> {
  List<XFile> imageFileList = [];
  int selectedImageIndex = -1;
  int screenFormat = 0;
  @override
  Widget build(BuildContext context) {
    screenFormat = Provider.of<EditorProvider>(context).screenFormat;
    imageFileList = Provider.of<EditorProvider>(context).imageFileList;
    selectedImageIndex =
        Provider.of<EditorProvider>(context).selectedImageIndex;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: Colors.white54,
        ),
        Builder(builder: (context) {
          switch (screenFormat) {
            case 0:
              return screen_1_1_real(context);
            case 1:
              return screen_16_9(context);
            case 2:
              return screen_9_16(context);
            case 3:
              return screen_4_3(context);
            case 4:
              return screen_3_4(context);
            default:
              return screen_1_1_real(context);
          }
        })
      ],
    );
  }

  // Widgets used in Editor screen
  Widget screen_1_1_real(BuildContext context) {
    context = this.context;
    return LayoutBuilder(builder: (context, constraints) {
      double size = constraints.maxWidth < constraints.maxHeight
          ? constraints.maxWidth
          : constraints.maxHeight;
      return Container(
        color: Colors.black,
        width: size,
        height: size,
        child: content(context),
      );
    });
  }

  Widget screen_16_9(BuildContext context) {
    context = this.context;
    return LayoutBuilder(builder: (context, constraints) {
      bool constraint = constraints.maxWidth < (constraints.maxHeight * 9 / 16)
          ? true
          : false;

      if (constraint) {
        return Container(
          color: Colors.black,
          width: constraints.maxWidth,
          height: constraints.maxWidth * 16 / 9,
          child: content(context),
        );
      } else {
        return Container(
          color: Colors.black,
          width: constraints.maxHeight * 9 / 16,
          height: constraints.maxHeight,
          child: content(context),
        );
      }
    });
  }

  Widget screen_9_16(BuildContext context) {
    context = this.context;
    return LayoutBuilder(builder: (context, constraints) {
      bool constraint = constraints.maxHeight < (constraints.maxWidth * 9 / 16)
          ? true
          : false;

      if (constraint) {
        return Container(
          color: Colors.black,
          width: constraints.maxHeight * 16 / 9,
          height: constraints.maxHeight,
          child: content(context),
        );
      } else {
        return Container(
          color: Colors.black,
          width: constraints.maxWidth,
          height: constraints.maxWidth * 9 / 16,
          child: content(context),
        );
      }
    });
  }

  Widget screen_4_3(BuildContext context) {
    context = this.context;
    return LayoutBuilder(builder: (context, constraints) {
      bool constraint =
          constraints.maxWidth < (constraints.maxHeight * 3 / 4) ? true : false;

      if (constraint) {
        return Container(
          color: Colors.black,
          width: constraints.maxWidth,
          height: constraints.maxWidth * 4 / 3,
          child: content(context),
        );
      } else {
        return Container(
          color: Colors.black,
          width: constraints.maxHeight * 3 / 4,
          height: constraints.maxHeight,
          child: content(context),
        );
      }
    });
  }

  Widget screen_3_4(BuildContext context) {
    context = this.context;
    return LayoutBuilder(builder: (context, constraints) {
      bool constraint =
          constraints.maxHeight < (constraints.maxWidth * 3 / 4) ? true : false;

      if (constraint) {
        return Container(
          color: Colors.black,
          width: constraints.maxHeight * 4 / 3,
          height: constraints.maxHeight,
          child: content(context),
        );
      } else {
        return Container(
          color: Colors.black,
          width: constraints.maxWidth,
          height: constraints.maxWidth * 3 / 4,
          child: content(context),
        );
      }
    });
  }

  Widget? content(BuildContext context) {
    context = this.context;
    return selectedImageIndex != -1
        ? Image.file(
            File(imageFileList[selectedImageIndex].path),
            fit: BoxFit.cover,
          )
        : null;
  }
}

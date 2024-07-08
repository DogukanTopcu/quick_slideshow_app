import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_slideshow/components/image_transitions/fadeTransition.dart';
import 'package:quick_slideshow/models/image_model.dart';
import 'package:quick_slideshow/providers/editorProvider.dart';
import 'package:quick_slideshow/screen/upgrade.dart';

class EditorArea extends StatefulWidget {
  const EditorArea({super.key});

  @override
  State<EditorArea> createState() => _EditorAreaState();
}

class _EditorAreaState extends State<EditorArea> {
  // MOCK ATTRIBUTES :::::::::::::::::::::::::::::::::::::::::::::::::..
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

  double _imageScale = 1;
  // :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

  List<Uint8List> imageFileList = [];
  List<ImageData> imgFileList = [];

  int selectedImageIndex = -1;
  int screenFormat = 0;
  @override
  Widget build(BuildContext context) {
    screenFormat = Provider.of<EditorProvider>(context).screenFormat;

    imageFileList = Provider.of<EditorProvider>(context).imageFileList;
    imgFileList = Provider.of<EditorProvider>(context).imgFileList;

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
        child: ClipRect(child: content(context)),
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
          child: ClipRect(child: content(context)),
        );
      } else {
        return Container(
          color: Colors.black,
          width: constraints.maxHeight * 9 / 16,
          height: constraints.maxHeight,
          child: ClipRect(child: content(context)),
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
          child: ClipRect(child: content(context)),
        );
      } else {
        return Container(
          color: Colors.black,
          width: constraints.maxWidth,
          height: constraints.maxWidth * 9 / 16,
          child: ClipRect(child: content(context)),
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
          child: ClipRect(child: content(context)),
        );
      } else {
        return Container(
          color: Colors.black,
          width: constraints.maxHeight * 3 / 4,
          height: constraints.maxHeight,
          child: ClipRect(child: content(context)),
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
          child: ClipRect(child: content(context)),
        );
      } else {
        return Container(
          color: Colors.black,
          width: constraints.maxWidth,
          height: constraints.maxWidth * 3 / 4,
          child: ClipRect(child: content(context)),
        );
      }
    });
  }

  Widget? content(BuildContext context) {
    final _controller = GlobalKey<ExtendedImageEditorState>();
    context = this.context;

    List<Widget> images = [];
    for (var i = 0; i < imageFileList.length; i++) {
      images.add(
        ExtendedImage.memory(
          imageFileList[i],
          cacheRawData: true,
          fit: BoxFit.cover,
          extendedImageEditorKey: _controller,
          mode: ExtendedImageMode.gesture,
        ),
      );
    }
    return selectedImageIndex != -1
        ? Stack(
            children: [
              Positioned(
                bottom: 0,
                top: 0,
                right: 0,
                left: 0,
                child: FadeTransitionWidget(child: images[selectedImageIndex]),
              ),
              Positioned(
                  bottom: 2,
                  left: 2,
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Upgrade()),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "images/quick-slideshow-logo.png",
                          scale: 8,
                        ),
                        const Text(
                          "Quick",
                          style: TextStyle(fontSize: 10),
                        ),
                        const Text(
                          "Slideshow",
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ))
            ],
          )
        : Image.asset("images/quick-slideshow-logo.png");
  }

  Widget? content1(BuildContext context) {
    TransformationController viewTransformationController =
        TransformationController();

    double zoomFactor =
        selectedImageIndex == -1 ? 1 : imgFileList[selectedImageIndex].scale;
    double xTranslate =
        selectedImageIndex == -1 ? 1 : imgFileList[selectedImageIndex].xValue;
    double yTranslate =
        selectedImageIndex == -1 ? 1 : imgFileList[selectedImageIndex].yValue;

    viewTransformationController.value.setEntry(0, 0, zoomFactor);
    viewTransformationController.value.setEntry(1, 1, zoomFactor);
    viewTransformationController.value.setEntry(2, 2, zoomFactor);
    viewTransformationController.value.setEntry(0, 3, -xTranslate);
    viewTransformationController.value.setEntry(1, 3, -yTranslate);

    context = this.context;
    return selectedImageIndex != -1
        ? InteractiveViewer(
            maxScale: 5,
            transformationController: viewTransformationController,
            onInteractionUpdate: (ScaleUpdateDetails details) {},
            onInteractionEnd: (ScaleEndDetails details) {
              imgFileList[selectedImageIndex].scale =
                  viewTransformationController.value.getMaxScaleOnAxis();

              imgFileList[selectedImageIndex].xValue =
                  viewTransformationController.value.getTranslation()[0];
              imgFileList[selectedImageIndex].yValue =
                  viewTransformationController.value.getTranslation()[1];
            },
            child: Image.file(
              File(imgFileList[selectedImageIndex].imgUrl.path),
              fit: BoxFit.cover,
            ),
          )
        : null;
  }

  Widget content2(BuildContext context, double size) {
    context = this.context;
    return Transform(
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
    );
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
            child: Image.memory(
              imageFileList[selectedImageIndex],
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

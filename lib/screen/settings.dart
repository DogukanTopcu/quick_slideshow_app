import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_slideshow/providers/editorProvider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late int _screenFormat;
  late int imageDuration =
      Provider.of<EditorProvider>(context).slideshowData.secondsPerImage;

  @override
  void initState() {
    super.initState();
    _screenFormat = Provider.of<EditorProvider>(context, listen: false)
        .slideshowData
        .screenFormat;
  }

  Widget button(String text, int format) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(20),
      ),
      onPressed: _screenFormat == format
          ? null
          : () {
              setState(() {
                _screenFormat = format;
              });
            },
      child: Text(text),
    );
  }

  void _showAgePicker(BuildContext context) {
    int tempImageDuration = imageDuration;
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300.0,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                height: 200.0,
                child: CupertinoPicker(
                  itemExtent: 36.0,
                  onSelectedItemChanged: (int index) {
                    setState(() {
                      tempImageDuration = index + 1;
                    });
                  },
                  children: List<Widget>.generate(60, (int index) {
                    return Center(
                        child: Text(
                      (index + 1).toString(),
                      style: const TextStyle(color: Colors.black),
                    ));
                  }),
                ),
              ),
              CupertinoButton(
                child: const Text('Done'),
                onPressed: () {
                  setState(() {
                    imageDuration = tempImageDuration;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Settings",
                style: TextStyle(fontSize: 18),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<EditorProvider>(context, listen: false)
                      .changeScreenFormat(_screenFormat);
                  Provider.of<EditorProvider>(context, listen: false)
                      .changeImageDuration(imageDuration);
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
            ],
          )),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.deepPurpleAccent, Colors.deepOrangeAccent]),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Image Settings",
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: SizedBox(
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      button("1:1 Format", 0),
                      const SizedBox(height: 10),
                      button("16:9 Format Portrait", 1),
                      const SizedBox(height: 10),
                      button("16:9 Format Landscape", 2),
                      const SizedBox(height: 10),
                      button("4:3 Format Portrait", 3),
                      const SizedBox(height: 10),
                      button("4:3 Format Landscape", 4)
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Time Settings",
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Image Duration: "),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () => _showAgePicker(context),
                    child: Row(
                      children: [
                        Text(
                          imageDuration.toString(),
                          style: const TextStyle(color: Colors.black),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          "seconds",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

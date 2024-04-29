import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  final int initialScreenFormat;
  final Function initialChangeScreenFormat;
  const Settings(
      {super.key,
      required this.initialScreenFormat,
      required this.initialChangeScreenFormat});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late int _screenFormat;

  @override
  void initState() {
    super.initState();
    _screenFormat = widget.initialScreenFormat;
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
                  widget.initialChangeScreenFormat(_screenFormat);
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
            ],
          )),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _screenFormat == 0
                  ? null
                  : () {
                      setState(() {
                        _screenFormat = 0;
                      });
                    },
              child: const Text("1:1 Format"),
            ),
            ElevatedButton(
              onPressed: _screenFormat == 1
                  ? null
                  : () {
                      setState(() {
                        _screenFormat = 1;
                      });
                    },
              child: const Text("16:9 Format"),
            ),
            ElevatedButton(
              onPressed: _screenFormat == 2
                  ? null
                  : () {
                      setState(() {
                        _screenFormat = 2;
                      });
                    },
              child: const Text("9:16 Format"),
            ),
            ElevatedButton(
              onPressed: _screenFormat == 3
                  ? null
                  : () {
                      setState(() {
                        _screenFormat = 3;
                      });
                    },
              child: const Text("4:3 Format"),
            ),
            ElevatedButton(
              onPressed: _screenFormat == 4
                  ? null
                  : () {
                      setState(() {
                        _screenFormat = 4;
                      });
                    },
              child: const Text("3:4 Format"),
            ),
          ],
        ),
      ),
    );
  }
}

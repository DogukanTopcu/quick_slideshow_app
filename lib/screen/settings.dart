import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  final int initialScreenFormat;
  const Settings({required this.initialScreenFormat});

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
                  Navigator.pop(context, _screenFormat);
                },
                icon: const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
            ],
          )),
    );
  }
}

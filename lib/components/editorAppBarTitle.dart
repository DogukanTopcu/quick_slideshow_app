import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_slideshow/home.dart';
import 'package:quick_slideshow/providers/editorProvider.dart';
import 'package:quick_slideshow/screen/settings.dart';

class EditorAppBarTitle extends StatefulWidget {
  const EditorAppBarTitle({super.key});

  @override
  State<EditorAppBarTitle> createState() => _EditorAppBarTitleState();
}

class _EditorAppBarTitleState extends State<EditorAppBarTitle> {
  String documentName = "";
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    documentName =
        Provider.of<EditorProvider>(context).slideshowData.documentName;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Provider.of<EditorProvider>(context, listen: false).initState();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const MyHomePage()));
          },
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
        GestureDetector(
          onTap: () {
            _openPanel();
          },
          child: Text(
            documentName,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Settings()));
          },
          icon: const Icon(
            Icons.settings,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  void _openPanel() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _textEditingController,
                decoration: const InputDecoration(labelText: 'Yeni Metin'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      if (_textEditingController.text.isEmpty) {
                        _showsnackbar("The file name cannot be blank");
                      } else {
                        Provider.of<EditorProvider>(context, listen: false)
                            .changeDocumentName(_textEditingController.text);
                      }
                    },
                    child: const Text('Onayla'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('İptal Et'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showsnackbar(String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 1),
        ),
      );
}

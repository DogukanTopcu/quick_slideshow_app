import 'package:flutter/material.dart';
import 'package:quick_slideshow/screen/editor.dart';
import 'package:quick_slideshow/screen/upgrade.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isEmpty = true;

  void chanceIsEmpty() {
    setState(() {
      isEmpty = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                    image: AssetImage("images/quick-slideshow-logo.png"),
                    width: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Slideshow Maker',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Save Memories',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Upgrade()));
              },
              icon: const Icon(
                Icons.workspace_premium_outlined,
                color: Colors.amber,
              ),
            ),
          ],
        ),
      ),
      body: Center(
          child: isEmpty
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Henüz hiçbir proje oluşturulmadı',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Proje oluşturmak için + butonuna basınız.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10), // Boşluk ekleyelim
                    // Image.asset('assets/placeholder_image.png', width: 100), // Soluk resim
                  ],
                )
              : const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Önceki Projeler', // Önceki projelerin listesi buraya gelecek
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Editor()));
        },
        backgroundColor: Colors.deepPurpleAccent,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}

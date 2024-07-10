import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_slideshow/models/slideshowModel.dart';
import 'package:quick_slideshow/providers/editorProvider.dart';
import 'package:quick_slideshow/providers/homeProvider.dart';
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

  void _showDeleteDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure you want to delete?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Provider.of<HomeScreenProvider>(context, listen: false)
                    .deleteSlideshowData(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    HomeScreenProvider homeProviderFunc =
        Provider.of<HomeScreenProvider>(context, listen: false);

    List<SlideshowData> slideshows =
        Provider.of<HomeScreenProvider>(context).slideshows;

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
                Navigator.push(context,
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
          child: slideshows.isEmpty
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No project has been created yet',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Press the + button to create a project.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10), // Boşluk ekleyelim
                    // Image.asset('assets/placeholder_image.png', width: 100), // Soluk resim
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Projects', // Önceki projelerin listesi buraya gelecek
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // 2 sütunlu grid
                            childAspectRatio: 3 / 2, // Item'lerin boyut oranı
                          ),
                          itemCount: slideshows.length,
                          itemBuilder: (context, index) {
                            final data = slideshows[index];
                            return GestureDetector(
                              onTap: () {
                                Provider.of<EditorProvider>(context,
                                        listen: false)
                                    .loadData(data);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Editor()));
                              },
                              child: Card(
                                margin: const EdgeInsets.all(8.0),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    data.imageFileList.isEmpty
                                        ? Image.asset(
                                            "images/quick-slideshow-logo.png")
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.memory(
                                              color: Colors.black,
                                              data.imageFileList[0],
                                              fit: BoxFit.cover,
                                              colorBlendMode: BlendMode.color,
                                            ),
                                          ),
                                    GridTile(
                                      footer: Container(
                                        color: Colors.black54,
                                        padding: const EdgeInsets.all(4),
                                        child: Text(
                                          data.documentName,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.underline),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      header: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            color: Colors.redAccent,
                                            onPressed: () {
                                              _showDeleteDialog(
                                                  context, data.id);
                                            },
                                          ),
                                        ],
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          SlideshowData newSlideshow =
              await homeProviderFunc.addEmptySlideshowData();

          if (context.mounted) {
            Provider.of<EditorProvider>(context, listen: false)
                .loadData(newSlideshow);

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Editor()));
          }
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

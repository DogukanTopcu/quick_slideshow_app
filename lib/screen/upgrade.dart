import 'package:flutter/material.dart';
import 'package:quick_slideshow/home.dart';

class Upgrade extends StatelessWidget {
  const Upgrade({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage()));
                  },
                  icon: const Icon(Icons.close)),
              const Text("Upgrades"),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Restore",
                  selectionColor: Colors.white,
                ),
              )
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.deepPurpleAccent, Colors.deepOrangeAccent])),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 0, 0, 0.5),
                  border: Border.all(color: Colors.white, width: 3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      leading: Icon(Icons.check, color: Colors.amber),
                      title: Text(
                        'Unlimited Photos',
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.check, color: Colors.amber),
                      title: Text('Unlock Stock Music'),
                    ),
                    ListTile(
                      leading: Icon(Icons.check, color: Colors.amber),
                      title: Text('Unlock All Transitions'),
                    ),
                    ListTile(
                      leading: Icon(Icons.check, color: Colors.amber),
                      title: Text('Unlock All Text Options'),
                    ),
                    ListTile(
                      leading: Icon(Icons.check, color: Colors.amber),
                      title: Text('Unlock All Filters'),
                    ),
                    ListTile(
                      leading: Icon(Icons.check, color: Colors.amber),
                      title: Text('Unlock Sketch'),
                    ),
                    ListTile(
                      leading: Icon(Icons.check, color: Colors.amber),
                      title: Text('Remove Watermark'),
                    ),
                    ListTile(
                      leading: Icon(Icons.check, color: Colors.amber),
                      title: Text('Remove Final Slide'),
                    ),
                    ListTile(
                      leading: Icon(Icons.check, color: Colors.amber),
                      title: Text('Remove Adds'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  ),
                  child: const Center(
                    child: Column(
                      children: [Text("1 MONTH"), Text("₺122.99")],
                    ),
                  )),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: Colors.white,
                ),
                child: const Text('FOREVER\n₺699.99',
                    style: TextStyle(color: Colors.deepPurple)),
              ),
              const SizedBox(height: 20),
              const Text(
                'Payment will be charged to iTunes account at confirmation of purchase.',
                style: TextStyle(fontSize: 8),
              ),
            ],
          )),
        ));
  }
}

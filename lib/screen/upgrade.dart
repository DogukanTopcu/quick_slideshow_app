import 'dart:ui';

import 'package:flutter/material.dart';

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
              const Text("Upgrades"),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Restore",
                  style: TextStyle(color: Colors.white),
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
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 0, 0, 0.5),
                  border: Border.all(color: Colors.white, width: 3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.check, color: Colors.amber),
                          SizedBox(width: 10),
                          Text(
                            'Unlimited Photos',
                            style: TextStyle(
                                fontSize: 18, fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.check, color: Colors.amber),
                          SizedBox(width: 10),
                          Text('Unlock Stock Music',
                              style: TextStyle(
                                  fontSize: 18, fontStyle: FontStyle.italic)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.check, color: Colors.amber),
                          SizedBox(width: 10),
                          Text('Unlock All Transitions',
                              style: TextStyle(
                                  fontSize: 18, fontStyle: FontStyle.italic)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.check, color: Colors.amber),
                          SizedBox(width: 10),
                          Text('Unlock All Text Options',
                              style: TextStyle(
                                  fontSize: 18, fontStyle: FontStyle.italic)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.check, color: Colors.amber),
                          SizedBox(width: 10),
                          Text('Unlock All Filters',
                              style: TextStyle(
                                  fontSize: 18, fontStyle: FontStyle.italic)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.check, color: Colors.amber),
                          SizedBox(width: 10),
                          Text('Unlock Sketch',
                              style: TextStyle(
                                  fontSize: 18, fontStyle: FontStyle.italic)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.check, color: Colors.amber),
                          SizedBox(width: 10),
                          Text('Remove Watermark',
                              style: TextStyle(
                                  fontSize: 18, fontStyle: FontStyle.italic)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.check, color: Colors.amber),
                          SizedBox(width: 10),
                          Text('Remove Final Slide',
                              style: TextStyle(
                                  fontSize: 18, fontStyle: FontStyle.italic)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.check, color: Colors.amber),
                          SizedBox(width: 10),
                          Text('Remove Adds',
                              style: TextStyle(
                                  fontSize: 18, fontStyle: FontStyle.italic)),
                        ],
                      ),
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
                    widthFactor: 1.5,
                    child: Column(
                      children: [
                        Text("1 MONTH",
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 18)),
                        Text(
                          "₺122.99",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        )
                      ],
                    ),
                  )),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  ),
                  child: const Center(
                    widthFactor: 1.5,
                    child: Column(
                      children: [
                        Text(
                          "FOREVER",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Colors.deepPurpleAccent,
                              fontSize: 18),
                        ),
                        Text(
                          "₺699.99",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.deepPurpleAccent,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Center(
                  child: Text(
                    'Payment will be charged to iTunes account at confirmation of purchase. Payment will be charged to iTunes account at confirmation of purchase. Payment will be charged to iTunes account at confirmation of purchase. Payment will be charged to iTunes account at confirmation of purchase. Payment will be charged to iTunes account at confirmation of purchase. Payment will be charged to iTunes account at confirmation of purchase.',
                    style: TextStyle(
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          )),
        ));
  }
}

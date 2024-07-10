import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quick_slideshow/home.dart';
import 'package:quick_slideshow/providers/editorProvider.dart';
import 'package:provider/provider.dart';
import 'package:quick_slideshow/providers/homeProvider.dart';

void main() async {
  // Initialize hive
  await Hive.initFlutter();

  // Create a box
  // var box = await Hive.openBox("Projects");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => EditorProvider(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => HomeScreenProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Provider.of<HomeScreenProvider>(context, listen: false).loadData();
    return MaterialApp(
      title: 'Quick Slideshow',
      theme: ThemeData(
        brightness: Brightness.dark, // Koyu tema
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

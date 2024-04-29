import 'package:flutter/material.dart';
import 'package:quick_slideshow/home.dart';

// TODOS:
/*
 1. Ekran seçeneklerinin oluşturulması
 2. Fotoğrafların ekrana oturtulması
 3. Fotoğrafın ekrandaki konumunun el ile ayarlanabilmesi
 4. Fotoğraf Editleme Ekranı
 5. Ses parçası yükleme butonu
 6. Slide Geçişleri
 7. Editor'e zaman çizelgesinin eklenmesi
 8. Play butonuna basıldığında video'nun akması
 9. Text Alanının Eklenmesi
10. Çizim Alanının Eklenmesi
11. Kayıt sistemi
12. Ana Sayfanın düzenlenmesi
13. Export işlemleri
*/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quick Slideshow',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 66, 183, 58)),
        brightness: Brightness.dark, // Koyu tema
        primarySwatch: Colors.blue,
        // useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

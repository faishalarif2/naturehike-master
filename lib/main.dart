import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:naturehike/view/barang.dart';
import 'package:naturehike/view/home.dart';
import 'package:naturehike/view/login.dart';
import 'package:naturehike/view/peminjam.dart';
import 'package:naturehike/view/peminjamanview.dart';

import 'package:naturehike/view/register.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NatureHike',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => Login(), // Ganti LoginPage dengan halaman login yang sesuai dalam aplikasi Anda
        // Daftar rute lainnya
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) =>
          Directionality(textDirection: TextDirection.rtl, child: child!),
      theme: ThemeData(primaryColor: const Color.fromRGBO(73, 187, 158, 1)),
      home: const Home_Page(),
      debugShowCheckedModeBanner: false,
    );
  }
}

import 'package:flutter/material.dart';
import '../components/category.dart';
import 'Rooms.dart';

// ignore: camel_case_types
class Home_Page extends StatelessWidget {
  const Home_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 76, 147, 175),
          title: const Center(
            child: Text(
              'الرئيسية',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'El Messiri', fontSize: 25),
            ),
          ),
        ),
        body: Column(
          children: [
            category(
              name_category: 'الغرف',
              D_category: '{...}',
              ontap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Rooms(),
                  )),
            ),
            category(
              name_category: 'الحجوزات',
              D_category: '{...}',
              ontap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Rooms(),
                  )),
            ),
            category(
              name_category: 'تقارير الحجوزات',
              D_category: '{...}',
              ontap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Rooms(),
                  )),
            ),
            category(
              name_category: 'الخدمات الاضافية',
              D_category: '{...}',
              ontap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Rooms(),
                  )),
            ),
          ],
        ));
  }
}

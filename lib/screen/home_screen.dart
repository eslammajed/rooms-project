import 'package:flutter/material.dart';
import 'package:neew/components/service.dart';
import 'package:neew/screen/bookings_screen.dart';
import 'package:neew/screen/customers_screen.dart';
import 'package:neew/widgets/main_drawer.dart';
import 'rooms_screen.dart';

// ignore: camel_case_types
class Home_Page extends StatelessWidget {
  const Home_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MainDrawer(),
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
            Service(
              name_category: 'الغرف',
              D_category: '{...}',
              ontap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RoomsScreen(),
                  )),
            ),
            Service(
              name_category: 'الحجوزات',
              D_category: '{...}',
              ontap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingsScreen(),
                  )),
            ),
            Service(
              name_category: 'العملاء ',
              D_category: '{...}',
              ontap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomersScreen(),
                  )),
            ),
            Service(
              name_category: 'الخدمات الاضافية',
              D_category: '{...}',
              ontap: () {},
            ),
          ],
        ));
  }
}

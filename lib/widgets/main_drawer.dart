import 'package:flutter/material.dart';
import 'package:neew/screen/rooms_screen.dart';
import 'package:neew/screen/bookings_screen.dart';
import 'package:neew/screen/customers_screen.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // رأس القائمة مع عنوان وألوان
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'القائمة الرئيسية',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          // عنصر للتنقل إلى شاشة الغرف
          ListTile(
            leading: Icon(Icons.room),
            title: Text('الغرف'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RoomsScreen(),
                ),
              );
            },
          ),
          // عنصر للتنقل إلى شاشة الحجوزات
          ListTile(
            leading: Icon(Icons.book),
            title: Text('الحجوزات'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingsScreen(),
                ),
              );
            },
          ),
          // عنصر للتنقل إلى شاشة العملاء
          ListTile(
            leading: Icon(Icons.person),
            title: Text('العملاء'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomersScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

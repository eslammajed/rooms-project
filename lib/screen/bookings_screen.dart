// ملف: screens/bookings_screen.dart

import 'package:flutter/material.dart';
import 'package:neew/screen/add_booking_screen.dart';
import 'package:neew/data/database_cntrollers.dart';
import '../models/booking.dart';

class BookingsScreen extends StatefulWidget {
  @override
  _BookingsScreenState createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  final DBHelper dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('قائمة الحجوزات')),
      body: FutureBuilder<List<Booking>>(
        future: dbHelper.getBookings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else if (snapshot.hasError)
            return Center(child: Text('حدث خطأ أثناء جلب الحجوزات'));
          else if (!snapshot.hasData || snapshot.data!.isEmpty)
            return Center(child: Text('لا توجد حجوزات مسجلة'));
          else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Booking booking = snapshot.data![index];
                return ListTile(
                  title: Text('حجز رقم ${booking.id}'),
                  subtitle: Text(
                      'تاريخ الحجز: ${booking.bookingDate}\nالسعر الإجمالي: ${booking.totalPrice}'),
                  isThreeLine: true,
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBookingScreen()),
          ).then((_) => setState(() {}));
        },
        child: Icon(Icons.add),
        tooltip: 'إضافة حجز جديد',
      ),
    );
  }
}

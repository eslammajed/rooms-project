
import 'package:flutter/material.dart';
import 'package:neew/screen/select_customer_screen.dart';
import 'package:neew/screen/select_room_screen.dart';
import 'package:neew/data/database_cntrollers.dart';
import '../models/booking.dart';
import '../models/customer.dart';
import '../models/room.dart';

class AddBookingScreen extends StatefulWidget {
  @override
  _AddBookingScreenState createState() => _AddBookingScreenState();
}

class _AddBookingScreenState extends State<AddBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bookingDateController = TextEditingController();
  final TextEditingController _checkInController = TextEditingController();
  final TextEditingController _checkOutController = TextEditingController();
  final TextEditingController _totalPriceController = TextEditingController();
  final DBHelper dbHelper = DBHelper();

  Customer? selectedCustomer;
  Room? selectedRoom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('إضافة حجز جديد')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // زر اختيار العميل
              ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SelectCustomerScreen()),
                  );
                  if (result != null && result is Customer) {
                    setState(() {
                      selectedCustomer = result;
                    });
                  }
                },
                child: Text(selectedCustomer == null
                    ? 'اختر العميل'
                    : 'العميل: ${selectedCustomer!.name}'),
              ),
              SizedBox(height: 16.0),
              // زر اختيار الغرفة
              ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectRoomScreen()),
                  );
                  if (result != null && result is Room) {
                    setState(() {
                      selectedRoom = result;
                    });
                  }
                },
                child: Text(selectedRoom == null
                    ? 'اختر الغرفة'
                    : 'الغرفة: ${selectedRoom!.roomName}'),
              ),
              SizedBox(height: 16.0),
              // باقي الحقول الخاصة بتفاصيل الحجز
              TextFormField(
                controller: _bookingDateController,
                decoration: InputDecoration(labelText: 'تاريخ الحجز'),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'من فضلك أدخل تاريخ الحجز';
                  return null;
                },
              ),
              TextFormField(
                controller: _checkInController,
                decoration: InputDecoration(labelText: 'تاريخ الدخول'),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'من فضلك أدخل تاريخ الدخول';
                  return null;
                },
              ),
              TextFormField(
                controller: _checkOutController,
                decoration: InputDecoration(labelText: 'تاريخ الخروج'),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'من فضلك أدخل تاريخ الخروج';
                  return null;
                },
              ),
              TextFormField(
                controller: _totalPriceController,
                decoration: InputDecoration(labelText: 'السعر الإجمالي'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'من فضلك أدخل السعر الإجمالي';
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('حفظ الحجز'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (selectedCustomer == null || selectedRoom == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('من فضلك اختر العميل والغرفة')),
                      );
                      return;
                    }
                    Booking booking = Booking(
                      customerId: selectedCustomer!.id!,
                      roomId: selectedRoom!.id!,
                      bookingDate: _bookingDateController.text,
                      checkIn: _checkInController.text,
                      checkOut: _checkOutController.text,
                      totalPrice: double.parse(_totalPriceController.text),
                    );
                    await dbHelper.insertBooking(booking);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

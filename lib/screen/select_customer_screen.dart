// ملف: screens/select_customer_screen.dart

import 'package:flutter/material.dart';
import 'package:neew/data/database_cntrollers.dart';
import '../models/customer.dart';

class SelectCustomerScreen extends StatelessWidget {
  final DBHelper dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('اختر العميل')),
      body: FutureBuilder<List<Customer>>(
        future: dbHelper.getCustomers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else if (snapshot.hasError)
            return Center(child: Text('خطأ في جلب العملاء'));
          else if (!snapshot.hasData || snapshot.data!.isEmpty)
            return Center(child: Text('لا يوجد عملاء'));
          else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Customer customer = snapshot.data![index];
                return ListTile(
                  title: Text(customer.name),
                  subtitle: Text(customer.email),
                  onTap: () {
                    Navigator.pop(context, customer);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

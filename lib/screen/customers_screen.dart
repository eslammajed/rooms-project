import 'package:flutter/material.dart';
import 'package:neew/screen/add_customer_screen.dart';
import '../data/database_cntrollers.dart';
import '../models/customer.dart';

class CustomersScreen extends StatefulWidget {
  @override
  _CustomersScreenState createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  final DBHelper dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('قائمة العملاء')),
      body: FutureBuilder<List<Customer>>(
        future: dbHelper.getCustomers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ في جلب البيانات'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('لا يوجد عملاء مسجلين'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Customer customer = snapshot.data![index];
                return ListTile(
                  title: Text(customer.name),
                  subtitle: Text(customer.email),
                  leading: Icon(Icons.person),
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
            MaterialPageRoute(builder: (context) => AddCustomerScreen()),
          ).then((_) => setState(() {}));
        },
        child: Icon(Icons.add),
        tooltip: 'إضافة عميل جديد',
      ),
    );
  }
}

// ملف: screens/add_customer_screen.dart

import 'package:flutter/material.dart';
import 'package:neew/data/database_cntrollers.dart';
import '../models/customer.dart';

class AddCustomerScreen extends StatefulWidget {
  @override
  _AddCustomerScreenState createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final DBHelper dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('إضافة عميل جديد')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'الاسم'),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'من فضلك أدخل الاسم';
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'البريد الإلكتروني'),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'من فضلك أدخل البريد الإلكتروني';
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'رقم الهاتف'),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'من فضلك أدخل رقم الهاتف';
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'العنوان'),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'من فضلك أدخل العنوان';
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('حفظ العميل'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Customer customer = Customer(
                      name: _nameController.text,
                      email: _emailController.text,
                      phone: _phoneController.text,
                      address: _addressController.text,
                    );
                    await dbHelper.insertCustomer(customer);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

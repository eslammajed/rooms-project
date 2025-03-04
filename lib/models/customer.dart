// ملف: models/customer.dart

/// فئة Customer تمثل بيانات العميل مثل الاسم والبريد الإلكتروني ورقم الهاتف والعنوان.
class Customer {
  final int? id;          // معرف العميل (يُولَّد تلقائيًا)
  final String name;      // اسم العميل
  final String email;     // البريد الإلكتروني
  final String phone;     // رقم الهاتف
  final String address;   // العنوان

  Customer({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  /// تحويل بيانات العميل إلى Map لتسهيل الإدراج في قاعدة البيانات.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
    };
  }

  /// إنشاء كائن Customer من Map (مثلاً عند استرجاع البيانات من قاعدة البيانات).
  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
    );
  }
}

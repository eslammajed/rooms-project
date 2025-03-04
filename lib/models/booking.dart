// ملف: models/booking.dart

/// فئة Booking تمثل بيانات الحجز مثل معرف العميل، معرف الغرفة، تواريخ الحجز والدخول والخروج والسعر الإجمالي.
class Booking {
  final int? id;            // معرف الحجز (يُولَّد تلقائيًا)
  final int customerId;     // معرف العميل (علاقة مع جدول العملاء)
  final int roomId;         // معرف الغرفة (علاقة مع جدول الغرف)
  final String bookingDate; // تاريخ إجراء الحجز
  final String checkIn;     // تاريخ الدخول
  final String checkOut;    // تاريخ الخروج
  final double totalPrice;  // السعر الإجمالي للحجز

  Booking({
    this.id,
    required this.customerId,
    required this.roomId,
    required this.bookingDate,
    required this.checkIn,
    required this.checkOut,
    required this.totalPrice,
  });

  /// تحويل بيانات الحجز إلى Map لتسهيل الإدراج في قاعدة البيانات.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'roomId': roomId,
      'bookingDate': bookingDate,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'totalPrice': totalPrice,
    };
  }

  /// إنشاء كائن Booking من Map عند استرجاع البيانات.
  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'],
      customerId: map['customerId'],
      roomId: map['roomId'],
      bookingDate: map['bookingDate'],
      checkIn: map['checkIn'],
      checkOut: map['checkOut'],
      totalPrice: map['totalPrice'],
    );
  }
}

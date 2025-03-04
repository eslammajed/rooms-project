// ملف: db_helper.dart

import 'dart:io';
import 'package:neew/models/room.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '/models/customer.dart';
import '/models/booking.dart';

/// فئة DBHelper تُدير عمليات قاعدة البيانات لتخزين بيانات الغرف والعملاء والحجوزات.
class DBHelper {
  Database? _database;
  int versionDb = 1;

  // أسماء الجداول
  String tableRooms = 'Rooms';
  String tableCustomers = 'Customers';
  String tableBookings = 'Bookings';

  // أعمدة جدول الغرف
  String columnRoomId = 'id';
  String columnRoomNumber = 'roomNumber';
  String columnRoomName = 'roomName';
  String columnDescription = 'description';
  String columnRoomType = 'roomType';
  String columnCapacity = 'capacity';
  String columnPricePerNight = 'pricePerNight';
  String columnImage = 'image';

  // أعمدة جدول العملاء
  String columnCustomerId = 'id';
  String columnCustomerName = 'name';
  String columnCustomerEmail = 'email';
  String columnCustomerPhone = 'phone';
  String columnCustomerAddress = 'address';

  // أعمدة جدول الحجوزات
  String columnBookingId = 'id';
  String columnBookingCustomerId = 'customerId';
  String columnBookingRoomId = 'roomId';
  String columnBookingDate = 'bookingDate';
  String columnCheckIn = 'checkIn';
  String columnCheckOut = 'checkOut';
  String columnTotalPrice = 'totalPrice';

  /// getter غير متزامن للحصول على قاعدة البيانات.
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  /// دالة لإنشاء قاعدة البيانات وتحديد مسارها وإنشاء الجداول عند الإنشاء.
  Future<Database> initDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path;
    return await openDatabase(
      '$path/hotel.db',
      version: versionDb,
      onCreate: (db, version) async {
        // إنشاء جدول الغرف
        await db.execute('''
          CREATE TABLE $tableRooms (
            $columnRoomId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnRoomNumber INTEGER,
            $columnRoomName TEXT,
            $columnDescription TEXT,
            $columnRoomType TEXT,
            $columnCapacity INTEGER,
            $columnPricePerNight REAL,
            $columnImage TEXT
          )
        ''');
        // إنشاء جدول العملاء
        await db.execute('''
          CREATE TABLE $tableCustomers (
            $columnCustomerId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnCustomerName TEXT,
            $columnCustomerEmail TEXT,
            $columnCustomerPhone TEXT,
            $columnCustomerAddress TEXT
          )
        ''');
        // إنشاء جدول الحجوزات مع مفاتيح خارجية لربطه بجدولي العملاء والغرف
        await db.execute('''
          CREATE TABLE $tableBookings (
            $columnBookingId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnBookingCustomerId INTEGER,
            $columnBookingRoomId INTEGER,
            $columnBookingDate TEXT,
            $columnCheckIn TEXT,
            $columnCheckOut TEXT,
            $columnTotalPrice REAL,
            FOREIGN KEY ($columnBookingCustomerId) REFERENCES $tableCustomers($columnCustomerId),
            FOREIGN KEY ($columnBookingRoomId) REFERENCES $tableRooms($columnRoomId)
          )
        ''');
      },
    );
  }

  // -------------------------------------------
  // دوال CRUD لجدول الغرف
  // -------------------------------------------
  /// دالة لإدراج غرفة جديدة في جدول الغرف.
  Future<int> insertRoom(Room room) async {
    final db = await database;
    return await db!.insert(tableRooms, room.toMap());
  }

  /// دالة لتحديث بيانات غرفة موجودة.
  Future<int> updateRoom(Room room) async {
    final db = await database;
    return await db!.update(
      tableRooms,
      room.toMap(),
      where: '$columnRoomId = ?',
      whereArgs: [room.id],
    );
  }

  /// دالة لحذف غرفة من جدول الغرف.
  Future<int> deleteRoom(int id) async {
    final db = await database;
    return await db!.delete(
      tableRooms,
      where: '$columnRoomId = ?',
      whereArgs: [id],
    );
  }

  /// دالة لاسترجاع جميع سجلات الغرف.
  Future<List<Room>> getRooms() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query(tableRooms);
    return List.generate(maps.length, (i) {
      return Room.fromMap(maps[i]);
    });
  }

  // -------------------------------------------
  // دوال CRUD لجدول العملاء
  // -------------------------------------------
  /// دالة لإدراج عميل جديد.
  Future<int> insertCustomer(Customer customer) async {
    final db = await database;
    return await db!.insert(tableCustomers, customer.toMap());
  }

  /// دالة لتحديث بيانات عميل موجود.
  Future<int> updateCustomer(Customer customer) async {
    final db = await database;
    return await db!.update(
      tableCustomers,
      customer.toMap(),
      where: '$columnCustomerId = ?',
      whereArgs: [customer.id],
    );
  }

  /// دالة لحذف عميل من جدول العملاء.
  Future<int> deleteCustomer(int id) async {
    final db = await database;
    return await db!.delete(
      tableCustomers,
      where: '$columnCustomerId = ?',
      whereArgs: [id],
    );
  }

  /// دالة لاسترجاع جميع سجلات العملاء.
  Future<List<Customer>> getCustomers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query(tableCustomers);
    return List.generate(maps.length, (i) {
      return Customer.fromMap(maps[i]);
    });
  }

  // -------------------------------------------
  // دوال CRUD لجدول الحجوزات
  // -------------------------------------------
  /// دالة لإدراج حجز جديد.
  Future<int> insertBooking(Booking booking) async {
    final db = await database;
    return await db!.insert(tableBookings, booking.toMap());
  }

  /// دالة لتحديث بيانات حجز موجود.
  Future<int> updateBooking(Booking booking) async {
    final db = await database;
    return await db!.update(
      tableBookings,
      booking.toMap(),
      where: '$columnBookingId = ?',
      whereArgs: [booking.id],
    );
  }

  /// دالة لحذف حجز من جدول الحجوزات.
  Future<int> deleteBooking(int id) async {
    final db = await database;
    return await db!.delete(
      tableBookings,
      where: '$columnBookingId = ?',
      whereArgs: [id],
    );
  }

  /// دالة لاسترجاع جميع سجلات الحجوزات.
  Future<List<Booking>> getBookings() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query(tableBookings);
    return List.generate(maps.length, (i) {
      return Booking.fromMap(maps[i]);
    });
  }
}

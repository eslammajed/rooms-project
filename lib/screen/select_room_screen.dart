// ملف: screens/select_room_screen.dart

import 'package:flutter/material.dart';
import 'package:neew/data/database_cntrollers.dart';
import '../models/room.dart';

class SelectRoomScreen extends StatelessWidget {
  final DBHelper dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('اختر الغرفة')),
      body: FutureBuilder<List<Room>>(
        future: dbHelper.getRooms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          else if (snapshot.hasError)
            return Center(child: Text('خطأ في جلب الغرف'));
          else if (!snapshot.hasData || snapshot.data!.isEmpty)
            return Center(child: Text('لا توجد غرف'));
          else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Room room = snapshot.data![index];
                return ListTile(
                  title: Text('غرفة ${room.roomNumber} - ${room.roomName}'),
                  subtitle: Text('السعر: ${room.pricePerNight}'),
                  onTap: () {
                    Navigator.pop(context, room);
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

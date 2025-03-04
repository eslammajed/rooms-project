// تجاهل قواعد التسمية لأننا نستخدم أسماء غير اعتيادية
// ignore_for_file: non_constant_identifier_names
// ignore: camel_case_types

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../screen/adite_room_screen.dart';
import '../data/database_cntrollers.dart';
import '../screen/rooms_screen.dart';
import '../models/room.dart';

// فئة listitme تُعرض عنصر (غرفة) في القائمة وتستجيب للنقر
class listitme extends StatefulWidget {
  // المُنشئ يستقبل كائن itme (الغرفة) ودالة عند النقر (ontap)
  listitme({super.key, required this.room, required this.ontap});

  final Room room;
  final Function() ontap;

  @override
  State<listitme> createState() => _listitmeState();
}

class _listitmeState extends State<listitme> {
  // مثيل من DBHelper لإجراء العمليات على قاعدة البيانات
  DBHelper dbhElper = DBHelper();

  @override
  void initState() {
    super.initState();
    // يمكن استخدام بيانات widget.room في initState إذا أردت التهيئة بناءً عليها
    // مثال: print(widget.room.Name);
  }

  @override
  Widget build(BuildContext context) {
    const double fsize = 14;

    return GestureDetector(
      onTap: widget.ontap,
      child: Container(
        margin: const EdgeInsets.all(10),
        color: const Color.fromARGB(255, 76, 155, 175),
        height: 150,
        child: Row(
          children: [
            Expanded(
              flex: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // عرض صورة الغرفة باستخدام Image.network إذا كان على الويب
                  // أو Image.file إذا كان على الجهاز
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      kIsWeb
                          ? Image.network(
                              widget.room.image,
                              height: 100,
                              width: 100,
                              fit: BoxFit.fill,
                              alignment: Alignment.center,
                            )
                          : Image.file(
                              File(widget.room.image),
                              height: 147,
                              width: 165,
                              fit: BoxFit.fill,
                              alignment: Alignment.center,
                            ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 10,
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'اسم الغرفه : ${widget.room.roomName}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'El Messiri',
                        fontSize: fsize,
                      ),
                    ),
                    Text(
                      'نوع الغرفة : ${widget.room.roomType}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'El Messiri',
                        fontSize: fsize,
                      ),
                    ),
                    Text(
                      'السعر مقابل الليلة : ${widget.room.pricePerNight}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'El Messiri',
                        fontSize: fsize,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            showDeleteConfirmationSnackBar(context);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                        // زر تعديل العنصر
                        IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AditeRroomScreen(room: widget.room),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit_square),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDeleteConfirmationSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text('هل أنت متأكد من الحذف؟'),
      action: SnackBarAction(
        label: 'نعم',
        onPressed: () {
          dbhElper.deleteRoom(widget.room.id!);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => RoomsScreen(),
          ));
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

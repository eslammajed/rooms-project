import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/room.dart';

class RoomInfoScreen extends StatefulWidget {
  const RoomInfoScreen({super.key, required this.room});
  final Room room;

  @override
  State<RoomInfoScreen> createState() => _RoomInfoScreenState();
}

class _RoomInfoScreenState extends State<RoomInfoScreen> {
  final Color color = const Color.fromARGB(255, 76, 168, 175);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 76, 172, 175),
        title: const Center(
          child: Text(
            'معلومات الغرفة',
            style: TextStyle(
                color: Colors.white, fontFamily: 'El Messiri', fontSize: 25),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: AlignmentDirectional.topStart,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                child: Expanded(
                  child: kIsWeb
                      ? Image.network(
                          widget.room.image,
                          height: 100,
                          width: 100,
                          fit: BoxFit.fill,
                          alignment: Alignment.center,
                        )
                      : Image.file(
                          File(widget.room.image),
                          height: 200,
                          width: 50,
                          fit: BoxFit.fill,
                          alignment: Alignment.center,
                        ),
                ),
              ),
              Mydivider(),
              MyText('الاسم', widget.room.roomName),
              Mydivider(),
              MyText('الوصف', widget.room.description),
              Mydivider(),
              MyText('السعر في الليلة', widget.room.pricePerNight),
              Mydivider(),
              MyText('النوع ', widget.room.roomType),
              Mydivider(),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Text MyText(String str, rooms) {
    return Text(
      '$str : $rooms',
      style: TextStyle(color: color, fontFamily: 'El Messiri', fontSize: 16),
    );
  }

  // ignore: non_constant_identifier_names
  Divider Mydivider() {
    return Divider(
      color: color,
      endIndent: 100,
    );
  }
}

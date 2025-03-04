// ignore_for_file: use_build_context_synchronously, must_be_immutable, prefer_const_constructors_in_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/room.dart';
import 'rooms_screen.dart';
import '../widgets/Custom_button.dart';
import '../data/database_cntrollers.dart';

class AddRoom extends StatefulWidget {
  AddRoom({super.key});

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  Room? room;
  final picker = ImagePicker();
  DBHelper dbhElper = DBHelper();

  void initstate() {
    super.initState();
  }

  TextEditingController roomName = TextEditingController();
  TextEditingController roomNumber = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController roomType = TextEditingController();
  File? Images;
  String? images;
  TextEditingController capacity = TextEditingController();
  TextEditingController Target = TextEditingController();
  TextEditingController pricePerNight = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('  اضافة غرفة '),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(MaterialPageRoute(
              builder: (context) => RoomsScreen(),
            ));
          },
          icon: Icon(Icons.arrow_back_sharp),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
        child: Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: roomName,
                decoration: const InputDecoration(
                  hintText: "اسم الغرفة",
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: roomNumber,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "رقم الغرفة",
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: description,
                decoration: const InputDecoration(
                  hintText: " الوصف",
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: roomType,
                decoration: const InputDecoration(
                  hintText: "نوع الغرفة",
                ),
              ),
              const SizedBox(height: 10),
              CustomButton(
                text: "اضافة الصورة",
                ontap: () {
                  setState(() {
                    getImages();
                  });
                },
                icon: const Icon(Icons.photo_library),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {});
                  },
                  icon: Icon(Icons.update)),
              Expanded(
                child: images != null
                    ? Image.file(
                        File(images!),
                        height: 200,
                        width: 150,
                        fit: BoxFit.fill,
                        alignment: Alignment.center,
                      )
                    : Container(),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: pricePerNight,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  hintText: "سعر اللية ",
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: capacity,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  hintText: "السعة",
                ),
              ),
              const SizedBox(height: 10),
              CustomButton(
                text: "اضافة الغرفة",
                ontap: () {
                  if (roomName.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('يرجى إدخال اسم الغرفة')),
                    );
                    return;
                  }
                  if (roomType.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('يرجى إدخال النوع')),
                    );
                    return;
                  }
                  if (description.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('يرجى إدخال الوصف ')),
                    );
                    return;
                  }
                  if (roomName.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('يرجى إدخال العنوان')),
                    );
                    return;
                  }
                  if (Images == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('يرجى اختيار صورة الغرفة')),
                    );
                    return;
                  }
                  if (pricePerNight.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('يرجى إدخال السعر')),
                    );
                    return;
                  }
                  if (capacity.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('يرجى إدخال السعة')),
                    );
                    return;
                  }
                  try {
                    setState(() {
                      dbhElper.insertRoom(Room(
                          roomNumber: int.parse(roomNumber.text),
                          roomName: roomName.text,
                          description: description.text,
                          roomType: roomType.text,
                          capacity: int.parse(capacity.text),
                          pricePerNight: double.parse(pricePerNight.text),
                          image: images!));
                    });
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("تمت الإضافة"),
                          content: Text("تم إضافة الغرفة بنجاح"),
                          actions: <Widget>[
                            ElevatedButton(
                              child: Text("تم"),
                              onPressed: () {
                                CLeaningData();
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => RoomsScreen(),
                                ));
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } catch (e) {
                    // ... (معالجة الخطأ)
                  }
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),

      // إنشاء زرين لاختيار الصورة من الكاميرا أو المعرض
    );
  }

  Future getImages() async {
    final pickedFile = await picker.pickMultiImage(
        requestFullMetadata: true,
        imageQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000);
    List<XFile> xfilePick = pickedFile;

    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        Images = File(xfilePick[i].path);
        images = xfilePick[i].path;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
          const SnackBar(content: Text('Nothing is selected')));
    }
  }

  void CLeaningData() {
    roomName.clear();
    roomNumber.clear();
    description.clear();
    roomType.clear();
    pricePerNight.clear();
    capacity.clear();
  }
}

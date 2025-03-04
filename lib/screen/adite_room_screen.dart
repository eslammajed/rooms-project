// ignore_for_file: use_build_context_synchronously, must_be_immutable, prefer_const_constructors_in_immutables

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neew/models/room.dart';

import 'rooms_screen.dart';
import '../widgets/Custom_button.dart';
import '../data/database_cntrollers.dart';

class AditeRroomScreen extends StatefulWidget {
  AditeRroomScreen({super.key, required this.room});
  final Room room;

  @override
  State<AditeRroomScreen> createState() => _AditeRroomScreenState();
}

class _AditeRroomScreenState extends State<AditeRroomScreen> {
  final picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DBHelper dbhElper = DBHelper();

  // متحكمات النصوص لكل حقل من الحقول
  TextEditingController roomNumber = TextEditingController();
  TextEditingController roomName = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController roomType = TextEditingController();
  TextEditingController pricePerNight = TextEditingController();
  TextEditingController capacity = TextEditingController();

  // متغير لتخزين الصورة المختارة
  File? imageFile;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    // تعبئة المتحكمات بالبيانات الحالية للغرفة المُرسلة من الصفحة السابقة
    roomNumber.text = widget.room.roomNumber.toString();
    roomName.text = widget.room.roomName;
    description.text = widget.room.description;
    roomType.text = widget.room.roomType;
    pricePerNight.text = widget.room.pricePerNight.toString();
    capacity.text = widget.room.capacity.toString();
    imagePath = widget.room.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تعديل الغرفة'),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => RoomsScreen()),
            );
          },
          icon: const Icon(Icons.arrow_back_sharp),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // حقل رقم الغرفة
              TextFormField(
                controller: roomNumber,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "رقم الغرفة",
                ),
              ),
              const SizedBox(height: 10),
              // حقل اسم الغرفة
              TextFormField(
                controller: roomName,
                decoration: const InputDecoration(
                  hintText: "اسم الغرفة",
                ),
              ),
              const SizedBox(height: 10),
              // حقل الوصف
              TextFormField(
                controller: description,
                decoration: const InputDecoration(
                  hintText: "الوصف",
                ),
              ),
              const SizedBox(height: 10),
              // حقل نوع الغرفة
              TextFormField(
                controller: roomType,
                decoration: const InputDecoration(
                  hintText: "نوع الغرفة",
                ),
              ),
              const SizedBox(height: 10),
              // زر اختيار الصورة
              CustomButton(
                text: "اختيار الصورة",
                ontap: () {
                  getImages();
                },
                icon: const Icon(Icons.photo_library),
              ),
              const SizedBox(height: 10),
              // عرض الصورة المختارة (إن وُجدت)
              Container(
                height: 200,
                width: double.infinity,
                child: imagePath != null
                    ? Image.file(
                        File(imagePath!),
                        fit: BoxFit.fill,
                        alignment: Alignment.center,
                      )
                    : Container(),
              ),
              const SizedBox(height: 10),
              // حقل السعر لكل ليلة
              TextFormField(
                controller: pricePerNight,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  hintText: "السعر لكل ليلة",
                ),
              ),
              const SizedBox(height: 10),
              // حقل السعة
              TextFormField(
                controller: capacity,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "السعة",
                ),
              ),
              const SizedBox(height: 10),
              // زر تعديل الغرفة
              CustomButton(
                text: "تعديل الغرفة",
                ontap: () {
                  // التحقق من صحة البيانات المدخلة
                  if (roomNumber.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('يرجى إدخال رقم الغرفة')),
                    );
                    return;
                  }
                  if (roomName.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('يرجى إدخال اسم الغرفة')),
                    );
                    return;
                  }
                  if (roomType.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('يرجى إدخال نوع الغرفة')),
                    );
                    return;
                  }
                  if (description.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('يرجى إدخال الوصف')),
                    );
                    return;
                  }
                  if (imagePath == null) {
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
                    // تحديث بيانات الغرفة في قاعدة البيانات باستخدام DBHelper
                    dbhElper.updateRoom(
                      Room(
                        id: widget.room.id,
                        roomNumber: int.parse(roomNumber.text),
                        roomName: roomName.text,
                        description: description.text,
                        roomType: roomType.text,
                        capacity: int.parse(capacity.text),
                        pricePerNight: double.parse(pricePerNight.text),
                        image: imagePath!,
                      ),
                    );
                    // عرض رسالة تأكيد التعديل
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: const Text("تم تعديل الغرفة بنجاح"),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text("تم"),
                              onPressed: () {
                                cleanData();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } catch (e) {
                    // معالجة الخطأ وإظهار رسالة
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('حدث خطأ: $e')),
                    );
                  }
                },
                icon: const Icon(Icons.edit_square),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// دالة لاختيار صورة من المعرض باستخدام ImagePicker
  Future getImages() async {
    final List<XFile>? pickedFiles = await picker.pickMultiImage(
      requestFullMetadata: true,
      imageQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
    );
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      // استخدام آخر صورة مختارة
      setState(() {
        imageFile = File(pickedFiles.last.path);
        imagePath = pickedFiles.last.path;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لم يتم اختيار أي صورة')),
      );
    }
  }

  /// دالة لمسح البيانات المدخلة بعد التعديل
  void cleanData() {
    roomNumber.clear();
    roomName.clear();
    description.clear();
    roomType.clear();
    pricePerNight.clear();
    capacity.clear();
    setState(() {
      imageFile = null;
      imagePath = null;
    });
  }
}

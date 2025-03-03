// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../modles/itme.dart';
import '../pages/Rooms.dart';
import '../widgets/Custom_button.dart';
// ignore: unused_import
import '../controllers/database_cntrollers.dart';

// ignore: camel_case_types
class IdetPage extends StatefulWidget {
  // ignore: non_constant_identifier_names
  IdetPage({super.key, required this.rooms});
  final itme rooms;

  @override
  State<IdetPage> createState() => _IdetPageState();
}

class _IdetPageState extends State<IdetPage> {
  itme? marr;
  final picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DBHElper dbhElper = DBHElper();
  @override
  void initState() {
    super.initState();
    Name.text = widget.rooms.Name.toString();
    Type.text = widget.rooms.Type.toString();
    Quantity.text = widget.rooms.Quantity.toString();
    price.text = widget.rooms.price.toString();
    Address.text = widget.rooms.Address.toString();
    Target.text = widget.rooms.Target.toString();
    images = widget.rooms.Images;
  }

  // ignore: non_constant_identifier_names
  TextEditingController Name = TextEditingController();

  // ignore: non_constant_identifier_names
  TextEditingController Type = TextEditingController();

  // ignore: non_constant_identifier_names
  TextEditingController Quantity = TextEditingController();

  // ignore: non_constant_identifier_names
  TextEditingController Address = TextEditingController();

  // ignore: non_constant_identifier_names
  File? Images;
  String? images;

  // ignore: non_constant_identifier_names
  TextEditingController Date = TextEditingController();

  // ignore: non_constant_identifier_names
  TextEditingController Target = TextEditingController();

  TextEditingController price = TextEditingController();

  // ignore: non_constant_identifier_names
  String Mydate() {
    DateTime time = DateTime.now();

// تحويل الوقت إلى شكل نصي
    String timeStr = time.toString();

// استخراج السنة والشهر واليوم والساعة والدقيقة من النص
    return timeStr.substring(0, 16);
  }

  // تعريف مثيل من ImagePicker

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تعديل منتج'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
        child: Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: Name,
                decoration: const InputDecoration(
                  hintText: "اسم المنتج",
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: Type,
                decoration: const InputDecoration(
                  hintText: "نوع المنتح",
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: Quantity,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "كمية المنتح",
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: Address,
                decoration: const InputDecoration(
                  hintText: "العنوان",
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
              const SizedBox(height: 10),
              TextFormField(
                controller: Target,
                decoration: const InputDecoration(
                  hintText: "الهدف",
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: price,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  hintText: "السعر",
                ),
              ),
              const SizedBox(height: 10),
              CustomButton(
                text: "تعديل المنتج",
                ontap: () {
                  if (Name.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('يرجى إدخال اسم المنتج')),
                    );
                    return;
                  }
                  if (Type.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('يرجى إدخال نوع المنتج')),
                    );
                    return;
                  }
                  if (Quantity.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('يرجى إدخال كمية المنتج')),
                    );
                    return;
                  }
                  if (Address.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('يرجى إدخال العنوان')),
                    );
                    return;
                  }
                  if (Images == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('يرجى اختيار صورة المنتج')),
                    );
                    return;
                  }
                  if (Target.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('يرجى إدخال الهدف')),
                    );
                    return;
                  }
                  if (price.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('يرجى إدخال السعر')),
                    );
                    return;
                  }
                  try {
                    // ... (بقية الكود)
                    setState(() {
                      dbhElper.UpdateDataTable(itme(
                          id: widget.rooms.id,
                          Name: Name.text,
                          Type: Type.text,
                          Quantity: int.parse(Quantity.text),
                          price: double.parse(price.text),
                          Address: Address.text,
                          Images: images,
                          Date: Mydate(),
                          Target: Target.text));
                    });
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text("تم تعديل المنتج بنجاح"),
                          actions: <Widget>[
                            ElevatedButton(
                              child: Text("تم"),
                              onPressed: () {
                                CLeaningData();
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => Rooms(),
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
                icon: const Icon(Icons.edit_square),
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
    Name.clear();
    price.clear();
    Quantity.clear();
    Type.clear();
    Date.clear();
    Target.clear();
  }
}

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../modles/itme.dart';

class Cropinformation extends StatefulWidget {
  const Cropinformation({super.key, required this.Markets});
  final itme Markets;

  @override
  State<Cropinformation> createState() => _CropinformationState();
}

class _CropinformationState extends State<Cropinformation> {
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
                          widget.Markets.Images!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.fill,
                          alignment: Alignment.center,
                        )
                      : Image.file(
                          File(widget.Markets.Images!),
                          height: 200,
                          width: 50,
                          fit: BoxFit.fill,
                          alignment: Alignment.center,
                        ),
                ),
              ),
              Mydivider(),
              MyText('الوصف', widget.Markets.Name),
              Mydivider(),
              MyText('النوع', widget.Markets.Type),
              Mydivider(),
              MyText('السعر', widget.Markets.price),
              Mydivider(),
              MyText('العنوان', widget.Markets.Address),
              Mydivider(),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Text MyText(String str, Markets) {
    return Text(
      '$str : $Markets',
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

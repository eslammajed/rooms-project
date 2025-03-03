import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '/Processes/Adite.dart';
import '/controllers/database_cntrollers.dart';
import '../pages/Rooms.dart';
import '../modles/itme.dart';

// ignore: camel_case_types
class listitme extends StatefulWidget {
  // ignore: non_constant_identifier_names
  listitme({super.key, required this.Itme, required this.ontap});
  // ignore: non_constant_identifier_names
  final itme Itme;
  final Function() ontap;
  @override
  State<listitme> createState() => _listitmeState();
}

class _listitmeState extends State<listitme> {
  DBHElper dbhElper = DBHElper();

  void intistate() {
    super.initState();
    widget.Itme.Address;
    widget.Itme.Images;
    widget.Itme.Name;
    widget.Itme.Type;
    widget.Itme.price;
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
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      kIsWeb
                          ? Image.network(
                              widget.Itme.Images!,
                              height: 100,
                              width: 100,
                              fit: BoxFit.fill,
                              alignment: Alignment.center,
                            )
                          : Image.file(
                              File(widget.Itme.Images!),
                              height: 147,
                              width: 165,
                              fit: BoxFit.fill,
                              alignment: Alignment.center,
                            ),
                      Container(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Text(
                            widget.Itme.Date!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'El Messiri',
                                fontWeight: FontWeight.w900),
                          )),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 10,
              child: Container(
                margin: const EdgeInsets.only(
                  right: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الغرفة : ${widget.Itme.Name}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'El Messiri',
                          fontSize: fsize),
                    ),
                    Text(
                      'النوع : ${widget.Itme.Type}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'El Messiri',
                          fontSize: fsize),
                    ),
                    Text(
                      'العنون : ${widget.Itme.Address}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'El Messiri',
                          fontSize: fsize),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                showDeleteConfirmationSnackBar(context);
                              });
                            },
                            icon: Icon(Icons.delete)),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          IdetPage(rooms: widget.Itme),
                                    ));
                              });
                            },
                            icon: Icon(Icons.edit_square))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showDeleteConfirmationSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('هل أنت متأكد من الحذف؟'),
      action: SnackBarAction(
        label: 'نعم',
        onPressed: () {
          dbhElper.DeletDataTable(widget.Itme.id!);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Rooms(),
          ));
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

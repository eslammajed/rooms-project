// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

// ignore: camel_case_types
class category extends StatelessWidget {
  const category(
      {super.key,
      required this.name_category,
      required this.D_category,
      required this.ontap});
  final String? name_category;
  final String? D_category;
  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          margin: EdgeInsets.zero,
          color: const Color.fromARGB(255, 76, 147, 175),
          height: 150,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  Icons.category,
                  size: 40,
                  color: Colors.white,
                ),
                Text(
                  name_category!,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'El Messiri',
                      fontSize: 20),
                ),
                Text(
                  D_category!,
                  style: const TextStyle(
                      color: Color.fromARGB(164, 255, 255, 255),
                      fontFamily: 'El Messiri',
                      fontSize: 16),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}

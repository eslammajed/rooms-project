import 'package:flutter/material.dart';

class Myappbar extends StatelessWidget {
  const Myappbar({super.key,  this.App_name});
  final String? App_name;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: Center(
        child: Text(
          App_name!,
          style: const TextStyle(
              color: Colors.white, fontFamily: 'El Messiri', fontSize: 25),
        ),
      ),
    );
  }
}

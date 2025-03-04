import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.text, required this.ontap, required this.icon});
  final String text;
  final VoidCallback ontap;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        decoration: BoxDecoration(
            color: Color.fromARGB(82, 58, 55, 55),
            borderRadius: BorderRadius.circular(10)),
        width: double.infinity,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 23, color: Color.fromARGB(255, 0, 0, 0)),
          ),
          SizedBox(
            width: 10,
          ),
          icon,
        ]),
      ),
    );
  }
}

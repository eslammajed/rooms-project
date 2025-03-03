// ignore_for_file: body_might_complete_normally_nullable


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hinttext,
      required this.onchanged,
      required this.filteringTextInputFormatter});
  final String? hinttext;
  final Function(String)? onchanged;
  final String filteringTextInputFormatter;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'يرجئ ادخل قيمة';
        }
      },
      onChanged: onchanged,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(filteringTextInputFormatter)),

      ],
      decoration: InputDecoration(
        hintText: hinttext,
        label: Text(hinttext!),
        hintStyle: TextStyle(
          color: const Color.fromARGB(255, 8, 8, 8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: const Color.fromARGB(255, 38, 38, 38)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: const Color.fromARGB(255, 77, 74, 74)),
        ),
      ),
    );
  }
}

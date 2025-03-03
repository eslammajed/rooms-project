import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showSnackBar(BuildContext context, messag) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(messag)));
}

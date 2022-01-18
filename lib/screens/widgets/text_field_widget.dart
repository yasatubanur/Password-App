import 'package:flutter/material.dart';
import 'package:password_app/constants/constants.dart';

Widget buildTextField(String labelText, String hintText, String? errorText,
    TextEditingController controller) {
  return TextField(
    decoration: InputDecoration(
      labelText: labelText,
      hintText: hintText,
      errorText: errorText,
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: appGreen2),
      ),
    ),
    controller: controller,
  );
}

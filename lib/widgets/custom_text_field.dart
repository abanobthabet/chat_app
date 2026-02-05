import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  String? hinttext;
  IconData? iconsData;
  Function(String)? onchange;
  CustomTextField({this.hinttext, this.iconsData, this.onchange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty??true ) {
          return 'field is required';
        }
      },
      onChanged: onchange,
      decoration: InputDecoration(
        prefixIcon: Icon(iconsData, color: Colors.white),
        hintText: hinttext,
        hintStyle: TextStyle(color: Colors.white),
        focusedBorder: newMethod(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: OutlineInputBorder(),
      ),
    );
  }

  OutlineInputBorder newMethod() {
    return OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      );
  }
}

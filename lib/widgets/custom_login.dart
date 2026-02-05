import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomLogin extends StatelessWidget {
  VoidCallback? ontap;
  String? text;
  CustomLogin({this.text, this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        height: 45,
        width: double.infinity,
        child: Text(text!, style: TextStyle(fontSize: 22)),
      ),
    );
  }
}

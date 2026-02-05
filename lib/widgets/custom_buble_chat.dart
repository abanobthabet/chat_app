import 'package:chat_app/constants.dart';
import 'package:chat_app/models/masseges.dart';
import 'package:flutter/material.dart';

class CustomBubleChat extends StatelessWidget {
   CustomBubleChat({super.key,required this.masseges});
 final Masseges masseges;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.only(left: 16, top: 25, bottom: 25, right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: kPraimaryColor,
        ),
        child: Text(masseges.massege, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}


class CustomBubleChatForFrind extends StatelessWidget {
   CustomBubleChatForFrind({super.key,required this.masseges});
 final Masseges masseges;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.only(left: 16, top: 25, bottom: 25, right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          color: Colors.blueAccent,
        ),
        child: Text(masseges.massege, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

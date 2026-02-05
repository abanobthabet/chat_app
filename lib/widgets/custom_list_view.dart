import 'package:chat_app/models/masseges.dart';
import 'package:chat_app/widgets/custom_buble_chat.dart';
import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  List<Masseges> massegelist;
  ScrollController? controller;
  bool reverse;
  String email;
  
   CustomListView({required this.massegelist,this.controller,required this.reverse,required this.email});
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        reverse: reverse ,
        controller:controller ,
        itemCount: massegelist.length,
        itemBuilder: (context, index) {
          return massegelist[index].id==email? CustomBubleChat(masseges: massegelist[index],):
          CustomBubleChatForFrind(masseges: massegelist[index])
          ;
        },
      ),
    );
  }
}

import 'package:chat_app/constants.dart';
import 'package:chat_app/models/masseges.dart';
import 'package:chat_app/screens/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/widgets/custom_list_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chatscreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController controller =
      TextEditingController();

  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email =
        ModalRoute.of(context)!.settings.arguments
            as String;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPraimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Klogo, height: 50),
            Text('Chat'),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              if (state is ChatSuccess) {
                return CustomListView(
                  email: email,
                  reverse: true,
                  massegelist: state.massegeslist,
                  controller: _controller,
                );
              } else {
                return Center(child: Text('error'));
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(
                  context,
                ).sendMassege(massege: data, email: email);
                controller.clear();
                _controller.animateTo(
                  0,
                  duration: Duration(seconds: 1),
                  curve: Curves.easeIn,
                );
              },

              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: kPraimaryColor,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                hintText: 'Send massege',
                suffixIcon: Icon(
                  Icons.send,
                  color: kPraimaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

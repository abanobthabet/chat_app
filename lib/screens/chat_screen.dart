import 'package:chat_app/constants.dart';
import 'package:chat_app/models/masseges.dart';
import 'package:chat_app/widgets/custom_list_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chatscreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController controller = TextEditingController();

  CollectionReference masseges = FirebaseFirestore.instance.collection(
    Kcollectionmassege,
  );
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
   var email =ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPraimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset(Klogo, height: 50), Text('Chat')],
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: masseges.orderBy(KcreatedAt, descending: true).snapshots(),

        builder: (context, Snapshot) {
          List<Masseges> massegelist = [];
          for (var i = 0; i < Snapshot.data!.docs.length; i++) {
            massegelist.add(Masseges.fromjson(Snapshot.data!.docs[i]));
          }
          if (Snapshot.hasData) {
            return Column(
              children: [
                CustomListView(
                  email: email,
                  reverse: true,
                  massegelist: massegelist,
                  controller: _controller,
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      masseges.add({
                        Kmassege: data,
                        KcreatedAt: DateTime.now(),
                        Kid:email
                      });
                      controller.clear();
                      _controller.animateTo(
                        0,
                        duration: Duration(seconds: 1),
                        curve: Curves.easeIn,
                      );
                    },

                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: kPraimaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      hintText: 'Send massege',
                      suffixIcon: Icon(Icons.send, color: kPraimaryColor),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Text('loding');
          }
        },
      ),
    );
  }
}

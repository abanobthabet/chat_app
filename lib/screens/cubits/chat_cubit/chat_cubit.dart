import 'package:bloc/bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/masseges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference masseges = FirebaseFirestore.instance
      .collection(Kcollectionmassege);
  void sendMassege({
    required String massege,
    required String email,
  }) {
    masseges.add({
      Kmassege: massege,
      KcreatedAt: DateTime.now(),
      Kid: email,
    });
  }

  void getMassege() {
    masseges
        .orderBy(KcreatedAt, descending: true)
        .snapshots()
        .listen((event) {
          List<Masseges> massgelist = [];
          massgelist.clear;

          for (var element in event.docs) {
            massgelist.add(Masseges.fromjson(element));
          }

          emit(ChatSuccess(massegeslist: massgelist));
        });
  }
}

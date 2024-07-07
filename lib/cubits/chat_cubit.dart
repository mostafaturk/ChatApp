

import 'package:chatapp/cubits/chat_states.dart';
import 'package:chatapp/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../consts.dart';

class ChatCubit extends Cubit<ChatStates>{
  ChatCubit():super(ChatInitial());

  CollectionReference messages =
  FirebaseFirestore.instance.collection(kmessagescollection);

  List<Message>messagesList=[];


  void sendMessages({required String message,required String email}){

    try {
      messages.add({
        kmessage: message,
        kcreatAt: DateTime.now(),
        kid:email,
      });
    } on Exception catch (e) {
      // TODO
    }

  }

  void getMessages(){
    messages.orderBy(kcreatAt,descending: true).snapshots().listen((event) {
      //List<Message>messagesList=[];
      messagesList.clear();
      print(event.docs);
      for( var doc in event.docs){
        print('doc---${doc}');
        messagesList.add(Message.fromJson(doc));
      }
      emit(ChatSuccess(Messages: messagesList));
    });
  }

}
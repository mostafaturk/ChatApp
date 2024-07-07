
import 'package:chatapp/consts.dart';
import 'package:chatapp/cubits/chat_cubit.dart';
import 'package:chatapp/cubits/chat_states.dart';
import 'package:chatapp/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widget/chat_buble_forfriend.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key});

  static String id = 'chatpage';

  final _controller = ScrollController();

  List<Message>messagesList=[];


  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {


    var email = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kprimarycolor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(klogo, height: 50,),
            Text("Secret Chat"),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit,ChatStates>(
              builder:(context,state){
                var messagesList =BlocProvider.of<ChatCubit>(context).messagesList;
                return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messagesList.length,
                  itemBuilder: (context, i) {
                    return messagesList[i].id == email ? ChatBuble(
                      message: messagesList[i],
                    ) : ChatBubleforfriend(message: messagesList[i]);
                  });
  },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context).sendMessages
                  (message: data!, email: email!);
                controller.clear();
                _controller.animateTo(
                    0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              },

              decoration: InputDecoration(

                hintText: "send message",
                suffixIcon: Icon(Icons.send, color: kprimarycolor,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),

                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: kprimarycolor,
                    )
                ),

              ),
            ),
          )
        ],
      ),
    );
  }
}
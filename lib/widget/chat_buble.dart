import 'package:chatapp/model/message_model.dart';
import 'package:flutter/material.dart';

import '../consts.dart';
class ChatBuble extends StatelessWidget {
   ChatBuble({required this.message}) ;

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(32),
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        decoration: BoxDecoration(
            color: kprimarycolor,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(32),
                topLeft: Radius.circular(32),
                bottomRight: Radius.circular(32)

            )
        ),
        child:Text(message.message,
          style: TextStyle(
              color: Colors.white
          ),
        ) ,
      ),
    );
  }
}


class ChatBubleforfriend extends StatelessWidget {
  ChatBubleforfriend({required this.message}) ;

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(32),
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        decoration: BoxDecoration(
            color: Colors.orangeAccent,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(32),
                topLeft: Radius.circular(32),
                bottomLeft: Radius.circular(32)

            )
        ),
        child:Text(message.message,
          style: TextStyle(
              color: Colors.white
          ),
        ) ,
      ),
    );
  }
}


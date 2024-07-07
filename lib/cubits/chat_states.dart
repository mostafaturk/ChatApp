
 import '../model/message_model.dart';

abstract class ChatStates{}

 class ChatInitial extends ChatStates{}

 class ChatSuccess extends ChatStates{

 List<Message> Messages;

 ChatSuccess({required this.Messages});

 }
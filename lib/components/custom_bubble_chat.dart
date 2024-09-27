import 'package:flutter/material.dart';
import 'package:untitled/models/messages_model.dart';

import '../constants/constants.dart';

class ChatBubble extends StatelessWidget{
  final Message message;

  const ChatBubble({super.key, required this.message});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
          padding: EdgeInsets.only(top: 27,bottom: 27,left: 16,right: 16),


          child: Text(
           message.message,
            style: TextStyle(color: Colors.white),
          ),
          decoration: BoxDecoration(
            borderRadius:BorderRadius.only(
              topRight: Radius.circular(32),
              topLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ) ,
            color: kPrimaryColor,
          )),
    );
  }


}
class ChatBubbleFromFriend extends StatelessWidget{
  final Message message;

  const ChatBubbleFromFriend({super.key, required this.message});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
          padding: EdgeInsets.only(top: 27,bottom: 27,left: 16,right: 16),


          child: Text(
            message.message,
            style: TextStyle(color: Colors.white),
          ),
          decoration: BoxDecoration(
            borderRadius:BorderRadius.only(
              topRight: Radius.circular(32),
              topLeft: Radius.circular(32),
              bottomLeft: Radius.circular(32),
            ) ,
            color: Colors.lightBlue[800],
          )),
    );
  }


}
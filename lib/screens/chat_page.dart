import 'package:flutter/material.dart';
import 'package:untitled/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/custom_bubble_chat.dart';
import '../models/messages_model.dart';

class ChatPage extends StatelessWidget {
  CollectionReference messages = FirebaseFirestore.instance
      .collection(kMessagesCollection); //بناخد ريفرينس من الكوليكشن
  final _scrollController = ScrollController();
  static String id = 'chatPage'; //دي بتاعت ال routs

  TextEditingController myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String?;

    //هنستقبل الايميل اللي اتبعت من ال  login عشان نحدد دي رسالة مين
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messageList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messageList.add(Message.fromJson(snapshot.data!.docs[i]));
            }

            return Scaffold(
                appBar: AppBar(
                  backgroundColor: kPrimaryColor,
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        kLogo,
                        height: 60,
                      ),
                      Text(
                        'Chat',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                      //لو حطينا ليست جوا column لازم نقولها تتمدد وتاخد اكبر مكان

                      child: ListView.builder(
                        reverse: true,
                        controller: _scrollController,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {

                          return messageList[index].id == email
                              ? ChatBubble(
                                  message: messageList[index],
                                )
                              : ChatBubbleFromFriend(
                                  message: messageList[index]);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: myController,
                        // onSubmitted: (data) {
                        //   messages
                        //       .add(//بناخد الريفرنس ونضيف له add وندخل الداتا على شكل map
                        //           {
                        //     kMessage: data, //key:value
                        //     kCreatedAt: DateTime.now(),
                        //     'id': email
                        //   });
                        //   myController.clear();
                        //   _scrollController.animateTo(0,
                        //       duration: Duration(milliseconds: 300),
                        //       curve: Curves.easeIn);
                        // },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: (){
                              final messageText = myController.text;
                              if (messageText.isNotEmpty) {
                                messages.add({
                                  kMessage: messageText,
                                  kCreatedAt: DateTime.now(),
                                  'id': email,
                                });
                                myController.clear();
                                _scrollController.animateTo(0,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                              }
                            },
                           icon: Icon(Icons.send),
                            color: kPrimaryColor,
                          ),
                          hintText: 'Send Message',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: kPrimaryColor)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(color: kPrimaryColor)),
                        ),
                      ),
                    )
                  ],
                ));
          } else {
            return Scaffold(body: Center(child: Text('Loading ...')));
          }
        });
  }
}

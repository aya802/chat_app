import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/Register.dart';
import 'package:untitled/screens/chat_page.dart';
import 'package:untitled/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( ScholarChat());
}

class ScholarChat extends StatelessWidget {
  //const ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: LogIn(),
      routes: {
        LogIn.id:(context)=>LogIn(),
        Register.id:(context)=>Register(),
        ChatPage.id:(context)=>ChatPage()

      },
//initialRoute: LogIn.id,
    );
  }
}

//(FirebaseAuth.instance.currentUser!=null&&FirebaseAuth.instance.currentUser!.emailVerified)?ChatPage():
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:untitled/components/custom_button.dart';
import 'package:untitled/components/custom_text_field.dart';
import 'package:untitled/constants/constants.dart';
import 'package:untitled/screens/Register.dart';
import 'package:untitled/screens/chat_page.dart';

import '../helper/show_snack_bar.dart';

class LogIn extends StatefulWidget {
  static String id = 'loinRout';
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
 String ?email;
 String? password;
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();
 // const ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 50,
                ),
                Image.asset(
                  'assets/img/scholar.png',
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'Pacifico',
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 75,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(

                  hintText: 'Email',
                  onChanged: (data) {
                    email = data;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(

                    hintText: 'Password',
                    onChanged: (data) {
                      password = data;
                    }),
                SizedBox(
                  height: 10,
                ),
                CustomButton(
                    text: 'LOGIN',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});

                        try {
                          await loginUser();
                          if(FirebaseAuth.instance.currentUser!.emailVerified){
                            Navigator.pushNamed(context, ChatPage.id ,arguments: email);
                          }else {
                            FirebaseAuth.instance.currentUser!.sendEmailVerification();
                            showSnackBar(context, 'Please Verify Your Email');
                          }


                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showSnackBar(context, 'No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            showSnackBar(context,
                                'Wrong password provided for that user.');
                          }
                        } catch (e) {

                          showSnackBar(context, 'there was an error');
                        }
                        isLoading = false;
                        setState(() {});
                      }
                    }),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'don\'t have an account? ',
                      style: TextStyle(color: Colors.white),
                    ),
                    InkWell(
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, Register.id);
                        })
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}

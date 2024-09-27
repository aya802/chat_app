import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:untitled/components/custom_button.dart';
import 'package:untitled/components/custom_text_field.dart';
import 'package:untitled/constants/constants.dart';
import 'package:untitled/screens/login.dart';

import '../helper/show_snack_bar.dart';
import 'chat_page.dart';

class Register extends StatefulWidget {
  // const ({Key? key}) : super(key: key);
  static String id = 'registerRout';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  String ?email;
  String? password;
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

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
                      'REGISTER',
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
                    text: 'REGISTER',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});

                        try {
                          await registerUser();
                          FirebaseAuth.instance.currentUser!.sendEmailVerification();
                          Navigator.pushNamed(context, LogIn.id);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showSnackBar(context, 'weak-password');
                          } else if (e.code == 'email-already-in-use') {
                            showSnackBar(context,
                                'The account already exists for that email.');
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
                      'already have an account? ',
                      style: TextStyle(color: Colors.white),
                    ),
                    InkWell(
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.pop(context);
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


  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}

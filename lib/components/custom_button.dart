
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
 // const ({Key? key}) : super(key: key);
  CustomButton({this.onTap,this.text});
String? text;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)
        ),
        child: Center(
          child: Text(text!),
        ),
      ),
    );
  }
}

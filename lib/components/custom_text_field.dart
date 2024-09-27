import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
 // const ({Key? key}) : super(key: key);
 CustomTextField({this.hintText,this.onChanged});
String? hintText;
Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,

      validator: (data){
        if(data!.isEmpty){
          return 'it is empty ';
        }

      },

      onChanged: onChanged,
      decoration: InputDecoration(

        hintText: (hintText),
        hintStyle: TextStyle(color: Colors.white),

        enabledBorder:  OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white
            )
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white
            )
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white
          )
        )

      ),
    );
  }
}

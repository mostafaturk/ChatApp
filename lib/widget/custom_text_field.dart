import 'package:flutter/material.dart';
class customtextformfield extends StatelessWidget {
  customtextformfield({this.hintText,this.onChange,this.obscureText=false})  ;

  String? hintText;
Function (String)? onChange;

bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText:obscureText!,
      validator: (data){
        if(data!.isEmpty){
          return "field is require";
        }
      },
      onChanged:onChange ,
      decoration: InputDecoration(

        hintText:hintText ,
          hintStyle: TextStyle(
            color: Colors.white
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white
              )
          ) ,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white
              )
          )

      ),
    ) ;
  }
}

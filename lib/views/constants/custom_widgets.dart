import 'package:coupinos_project/views/constants/string_constants.dart';
import 'package:flutter/material.dart';

class CustomWidgets {

  Widget textField(String hintText ,TextEditingController emailController, Function checkInput, bool obscure, Widget? suffixIcon){
    return  TextFormField(
      onChanged: (value) {
        checkInput();
      },
      enabled: true,
      style: const TextStyle(color: Colors.black),
      controller: emailController,
      obscureText: obscure,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        //labelText: label, labelStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 16),
        fillColor: Colors.grey,
        hintText: hintText,
        hintStyle: const TextStyle(
            color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
              color: Colors.black,
              style: BorderStyle.solid
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
      ),
    );
  }

  Widget loginBottomBar(){
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 16.0, left: 80, right: 16, top: 10),
      child: Container(
          color: Colors.white,
          child: const Text(ConstantStrings.bottomText, style: TextStyle(
              color: Color(0xFFF8485E),
              fontWeight: FontWeight.w600,
              fontSize: 14),)),
    );
  }

  Widget loginButtonAble(Function() onPressed, Color backgroundColor){
    return  ElevatedButton(onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            ),
            fixedSize: const Size(393, 48)
        ),
        child: const Text(ConstantStrings.buttonText));
  }

  Widget loginButtonDisable(){
    return ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
        ),
        fixedSize: const Size(393, 48)
    ), child: const Text(ConstantStrings.buttonText),);
  }

  Widget homeAppBarButton(String text, double width, double height){
    return  ElevatedButton(onPressed: () {

    }, style: ElevatedButton.styleFrom(
      fixedSize: Size(width, height),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
        side: const BorderSide(width: 1, color: Colors.red),
      ),
    ),
      child:  Text(
        text, style: const TextStyle(color: Colors.red,
          fontSize: 14),),
    );
  }

  Widget homeDrawer(){
    return Column(
      children: const [
        ListTile(
          leading: Icon(Icons.verified_outlined),
          title: Text("Enter verificaton code", style: TextStyle(color: Colors.black, fontSize: 16),),
        ),
        ListTile(
          leading: Icon(Icons.person_outline),
          title: Text("My contents", style: TextStyle(color: Colors.black, fontSize: 16),),
        ),
        ListTile(
          leading: Icon(Icons.apartment_outlined),
          title: Text("Partner", style: TextStyle(color: Colors.black, fontSize: 16),),
        ),
        ListTile(
          leading: Icon(Icons.camera_alt_outlined),
          title: Text("Photo Album", style: TextStyle(color: Colors.black, fontSize: 16),),
        ),
        ListTile(
          leading: Icon(Icons.notifications_none_outlined),
          title: Text("Notifications", style: TextStyle(color: Colors.black, fontSize: 16),),
        ),
        ListTile(
          leading: Icon(Icons.timer_outlined),
          title: Text("Posts In Queue", style: TextStyle(color: Colors.black, fontSize: 16),),
        ),
        SizedBox(height: 150,),
        Divider(color: Colors.black,),
        ListTile(
          leading: Icon(Icons.settings_outlined),
          title: Text("Settings", style: TextStyle(color: Colors.black, fontSize: 16),),
        ),
        ]
    );
  }

}
import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  const CustomField({super.key, required this.label, required this.control, required this.obs, required this.hint});
  final String label;
  final String hint;
  final TextEditingController control;
  final bool obs;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 363,
      height: 64,
      child: TextFormField(
        enabled: true,
        style: const TextStyle(color: Colors.black),
        controller: control,
        obscureText: obs,
        decoration: InputDecoration(
          //labelText: label, labelStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 16),
          fillColor: Colors.grey,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
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
      ),
    );
  }
}

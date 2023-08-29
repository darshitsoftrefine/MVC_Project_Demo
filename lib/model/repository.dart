import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model.dart';
import 'package:http/http.dart' as http;
abstract class ContactRepository{
  Future<ContactPerson> getContactDetails();
}

class CoupinosLogin extends ContactRepository {

  @override
  Future<ContactPerson> getContactDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("email");
    var password = prefs.getString('password');
    try{
    final response = await http.post(
      Uri.parse('https://coupinos-app.azurewebsites.net/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email.toString(),
        'password': password.toString(),
      }),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      ContactPerson contDetails = ContactPerson.fromJson(data['contactPerson']);
      return contDetails;
    }} catch(e){
      debugPrint('$e');
    }
    throw Exception('Failed');
  }
}
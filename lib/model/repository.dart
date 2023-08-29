import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';
import 'package:http/http.dart' as http;
abstract class ContactRepository{
  Future<ContactPerson> getContactDetails();
}

class CoupinosLogin extends ContactRepository {

  @override
  Future<ContactPerson> getContactDetails() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString("email");
      var password = prefs.getString('password');
      final response = await http.post(Uri.parse('https://coupinos-app.azurewebsites.net/login'),
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
      } else {

      }
    } catch(e){
      SnackBar(content: Text("Error"));
      debugPrint('$e');
    }
      throw Exception("Error");
  }
  // Future<Address> getadrDetails() async {
  //   final response = await http.post(Uri.parse('https://coupinos-app.azurewebsites.net/login'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'email': 'learntest43+1@gmail.com',
  //       'password': 'Test@123',
  //     }),
  //   );
  //   var data1 = jsonDecode(response.body);
  //   print(data1['address']);
  //   if (response.statusCode == 200) {
  //     var data = json.decode(response.body);
  //     Address adrDetails = Address.fromJson(data['address']);
  //     return adrDetails;
  //   } else {
  //     throw Exception('Failed');
  //   }
  // }
}
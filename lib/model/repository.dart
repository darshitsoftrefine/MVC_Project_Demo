import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';
import 'package:http/http.dart' as http;
abstract class ContactRepository{
  Future<CoupinoModel> getContactDetails();
}

class CoupinosLogin extends ContactRepository {

  @override
  Future<CoupinoModel> getContactDetails() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString("email");
      var password = prefs.getString('password');
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
        debugPrint("Helo ${data['loginToken']}");
        debugPrint("Hello ${data['contactPerson']}");
        CoupinoModel contDetails = CoupinoModel.fromJson(data);
        return contDetails;
      } else {
      }
    } catch (e) {
      const SnackBar(content: Text("Error"));
      debugPrint('$e');
    }
    throw Exception("Error");
  }
}
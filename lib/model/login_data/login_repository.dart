import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'login_model.dart';
import 'package:http/http.dart' as http;

class CoupinosLogin {

  Future<CoupinoModel> getContactDetails(String email, String password) async {
    try {
      final response = await http.post(Uri.parse('https://coupinos-app.azurewebsites.net/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
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
import 'dart:convert';
import 'package:coupinos_project/model/post_get_data/post_get_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
abstract class PostRepository{
  Future<List<Posts>?> getPostDetails();
}

class PostGetFetch extends PostRepository {

  @override
  Future<List<Posts>?> getPostDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? obtainedToken = sharedPreferences.getString('loginToken');
    var response = await http.post(Uri.parse('https://coupinos-app.azurewebsites.net/post/get'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-access-token': obtainedToken!,
      },
      body: jsonEncode(<String, dynamic>{
        "radius": 10,
        "pageSize": 10,
        "page": 0,
        "longitude": 72.50369833333333,
        "latitude": 23.034296666666666
      }),
    );
    var data = json.decode(response.body.toString());
    if(response.statusCode == 200){

      List<Posts>? postedDetails = PostGetModel.fromJson(data).posts;
      //print(postedDetails);
      return postedDetails;
    } else {
      throw Exception('Failed');
    }
  }
}
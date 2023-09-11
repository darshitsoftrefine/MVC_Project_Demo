import 'dart:convert';
import 'package:coupinos_project/model/post_get_data/post_get_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
abstract class PostRepository{
  Future<List<Posts>?> getPostDetails(int radius, int pageSize, int page, double longitude, double latitude);
}

class PostGetFetch extends PostRepository {

  @override
  Future<List<Posts>?> getPostDetails(radius, pageSize, page, longitude, latitude) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? obtainedToken = sharedPreferences.getString('loginToken');
    var response = await http.post(Uri.parse('https://coupinos-app.azurewebsites.net/post/get'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-access-token': obtainedToken!,
      },
      body: jsonEncode(<String, dynamic>{
        "radius": radius,
        "pageSize": pageSize,
        "page": page,
        "longitude": longitude,
        "latitude": latitude
      }),
    );
    var data = json.decode(response.body.toString());
    if(response.statusCode == 200){

      List<Posts>? postedDetails = PostGetModel.fromJson(data).posts;
      return postedDetails;
    } else {
      throw Exception('Failed');
    }
  }
}
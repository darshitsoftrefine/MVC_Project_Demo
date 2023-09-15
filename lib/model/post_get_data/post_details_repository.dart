import 'dart:convert';
import 'package:coupinos_project/model/post_get_data/post_details_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
abstract class PostDetailsRepository{
  Future<Data?> getPostDetails();
}

class PostGetDetailsFetch extends PostDetailsRepository {
  @override
  Future<Data?> getPostDetails() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? obtainedToken = sharedPreferences.getString('loginToken');
    String? obtainedId = sharedPreferences.getString('id');
    print(obtainedId);
    var response = await http.get(Uri.parse('https://coupinos-app.azurewebsites.net/post/get/$obtainedId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-access-token': obtainedToken!,
      },
    );
    var data = json.decode(response.body);
    if(response.statusCode == 200){
      Data? postedDetails = PostDetailsModel.fromJson(data).data;
      return postedDetails;
    } else {
      throw Exception('Failed');
    }
  }
}
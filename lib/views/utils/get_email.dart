import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetEmail {

  late String local;

  Future<String?> getEmail() async {
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      local= preferences.getString('email')!;
      return local;
    } catch(e){
      debugPrint('Error: $e');
      return null;
    }
  }
}
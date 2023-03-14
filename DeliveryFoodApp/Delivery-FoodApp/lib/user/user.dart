import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  int id = 0;
  String name = '';
  String lastname = '';
  String username = '';
  String token = '';
  String imageName = '';
  bool auth = false;
  String aux = '';
  User();

  User.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json['name'];
    lastname = json['lastname'];
    username = json['username'];
    imageName = json['imageName'] != null? json['imageName'] : '';
    token = json['token'];
  }

  
}

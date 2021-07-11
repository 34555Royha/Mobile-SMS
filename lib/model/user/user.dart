// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'dart:convert';

import 'package:flutter_app_pms/configuration/BaseUrl.dart';
import 'package:flutter_app_pms/configuration/apiService.dart';
import 'package:flutter_app_pms/model/user/login.dart';
import 'package:http/http.dart' as http;

User userFromMap(String str) => User.fromMap(json.decode(str));

String userToMap(User data) => json.encode(data.toMap());

class User with ApiService{
    User({
        this.user,
        this.message,
        this.status,
    });

    UserClass user;
    String message;
    String status;

    factory User.fromMap(Map<String, dynamic> json) => User(
        user: UserClass.fromMap(json["User"]),
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toMap() => {
        "User": user.toMap(),
        "message": message,
        "status": status,
    };

        Future<http.Response> appLogin(Login login) async {
          var rsp = await ApiService().postAPINoToken(url: urlLogin, body: jsonEncode(login.toMap()));
    // var rsp = await http.post(
    //   urlLogin,
      // body: {
      //   'username': username,
      //   'password': password,
      // },
    //   headers: {
    //     // "Content-Type": "application/json",
    //     // "Accept": "application/json",
    //     // "Content-Type": "application/x-www-form-urlencoded"
    //   },
    //   // encoding: Encoding.getByName('utf-8'),
    // );

    return rsp;
  }
}

class UserClass {
    UserClass({
        this.apiKey,
        this.id,
        this.username,
        this.password,
        this.status,
        this.profileImg,
        this.roles,
    });

    String apiKey;
    int id;
    String username;
    String password;
    bool status;
    dynamic profileImg;
    dynamic roles;

    factory UserClass.fromMap(Map<String, dynamic> json) => UserClass(
        apiKey: json["apiKey"],
        id: json["id"],
        username: json["username"],
        password: json["password"],
        status: json["status"],
        profileImg: json["profileImg"],
        roles: json["roles"],
    );

    Map<String, dynamic> toMap() => {
        "apiKey": apiKey,
        "id": id,
        "username": username,
        "password": password,
        "status": status,
        "profileImg": profileImg,
        "roles": roles,
    };

    
}

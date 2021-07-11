// To parse this JSON data, do
//
//     final login = loginFromMap(jsonString);

import 'dart:convert';

Login loginFromMap(String str) => Login.fromMap(json.decode(str));

String loginToMap(Login data) => json.encode(data.toMap());

class Login {
    Login({
        this.password,
        this.username,
    });

    String password;
    String username;

    factory Login.fromMap(Map<String, dynamic> json) => Login(
        password: json["password"],
        username: json["username"],
    );

    Map<String, dynamic> toMap() => {
        "password": password,
        "username": username,
    };
}

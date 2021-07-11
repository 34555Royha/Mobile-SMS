// To parse this JSON data, do
//
//     final register = registerFromMap(jsonString);

import 'dart:convert';

Register registerFromMap(String str) => Register.fromMap(json.decode(str));

String registerToMap(Register data) => json.encode(data.toMap());

class Register {
    Register({
        this.password,
        this.profileImg,
        this.status,
        this.username,
    });

    String password;
    String profileImg;
    bool status;
    String username;

    factory Register.fromMap(Map<String, dynamic> json) => Register(
        password: json["password"],
        profileImg: json["profileImg"],
        status: json["status"],
        username: json["username"],
    );

    Map<String, dynamic> toMap() => {
        "password": password,
        "profileImg": profileImg,
        "status": status,
        "username": username,
    };
}

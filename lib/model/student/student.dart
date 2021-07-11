// To parse this JSON data, do
//
//     final student = studentFromMap(jsonString);

import 'dart:convert';

List<Student> studentFromMap(String str) => List<Student>.from(json.decode(str).map((x) => Student.fromMap(x)));

String studentToMap(List<Student> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Student {
    Student({
        this.name,
        this.id,
        this.address,
        this.sex,
        this.dateOfBirth,
        this.phone,
        this.photo,
        this.title,
    });

    String name;
    String id;
    String address;
    String sex;
    String dateOfBirth;
    String phone;
    String photo;
    String title;

    factory Student.fromMap(Map<String, dynamic> json) => Student(
        name: json["name"],
        id: json["id"],
        address: json["address"],
        sex: json["sex"],
        dateOfBirth: json["dateOfBirth"],
        phone: json["phone"],
        photo: json["photo"],
        title: json["title"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "id": id,
        "address": address,
        "sex": sex,
        "dateOfBirth": dateOfBirth,
        "phone": phone,
        "photo": photo,
        "title": title,
    };

    
}

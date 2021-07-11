import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;



class StudentList {
  StudentList studentFromMap(String str) => StudentList.fromMap(json.decode(str));

String studentToMap(StudentList data) => json.encode(data.toMap());
    StudentList({
        this.status,
        this.message,
        this.students,
        this.count,
    });

    String status;
    String message;
    List<StudentElement> students;
    int count;

    factory StudentList.fromMap(Map<String, dynamic> json) => StudentList(
        status: json["Status"],
        message: json["Message"],
        students: List<StudentElement>.from(json["students"].map((x) => StudentElement.fromMap(x))),
        count: json["Count"],
    );

    Map<String, dynamic> toMap() => {
        "Status": status,
        "Message": message,
        "students": List<dynamic>.from(students.map((x) => x.toMap())),
        "Count": count,
    };

  
}

class StudentElement {
    StudentElement({
        this.name,
        this.id,
        this.address,
        this.photo,
        this.sex,
        this.dateOfBirth,
        this.phone,
    });

    String name;
    String id;
    String address;
    String photo;
    String sex;
    String dateOfBirth;
    String phone;

    factory StudentElement.fromMap(Map<String, dynamic> json) => StudentElement(
        name: json["name"],
        id: json["id"],
        address: json["address"],
        photo: json["photo"],
        sex: json["sex"],
        dateOfBirth: json["dateOfBirth"],
        phone: json["phone"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "id": id,
        "address": address,
        "photo": photo,
        "sex": sex,
       "dateOfBirth": dateOfBirth,
       "phone": phone,
    };

     
}

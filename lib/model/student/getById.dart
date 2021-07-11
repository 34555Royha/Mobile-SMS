// To parse this JSON data, do
//
//     final getById = getByIdFromMap(jsonString);

import 'dart:convert';

GetById getByIdFromMap(String str) => GetById.fromMap(json.decode(str));

String getByIdToMap(GetById data) => json.encode(data.toMap());

class GetById {
    GetById({
        this.student,
        this.message,
        this.status,
    });

    Student student;
    String message;
    String status;

    factory GetById.fromMap(Map<String, dynamic> json) => GetById(
        student: Student.fromMap(json["student"]),
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toMap() => {
        "student": student.toMap(),
        "message": message,
        "status": status,
    };
}

class Student {
    Student({
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

    factory Student.fromMap(Map<String, dynamic> json) => Student(
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

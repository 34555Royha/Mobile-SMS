// To parse this JSON data, do
//
//     final createStudent = createStudentFromMap(jsonString);

import 'dart:convert';

CreateStudent createStudentFromMap(String str) => CreateStudent.fromMap(json.decode(str));

String createStudentToMap(CreateStudent data) => json.encode(data.toMap());

class CreateStudent {
    CreateStudent({
        this.address,
        this.dateOfBirth,
        this.name,
        this.phone,
        this.photo,
        this.sex,
    });

    String address;
    String dateOfBirth;
    String name;
    String phone;
    String photo;
    String sex;

    factory CreateStudent.fromMap(Map<String, dynamic> json) => CreateStudent(
        address: json["address"],
        dateOfBirth: json["dateOfBirth"],
        name: json["name"],
        phone: json["phone"],
        photo: json["photo"],
        sex: json["sex"],
    );

    Map<String, dynamic> toMap() => {
        "address": address,
        "dateOfBirth": dateOfBirth,
        "name": name,
        "phone": phone,
        "photo": photo,
        "sex": sex,
    };
}

// To parse this JSON data, do
//
//     final updateStudent = updateStudentFromMap(jsonString);

import 'dart:convert';

UpdateStudent updateStudentFromMap(String str) => UpdateStudent.fromMap(json.decode(str));

String updateStudentToMap(UpdateStudent data) => json.encode(data.toMap());

class UpdateStudent {
    UpdateStudent({
        this.address,
        this.dateOfBirth,
        this.id,
        this.name,
        this.phone,
        this.photo,
        this.sex,
    });

    String address;
    String dateOfBirth;
    String id;
    String name;
    String phone;
    String photo;
    String sex;

    factory UpdateStudent.fromMap(Map<String, dynamic> json) => UpdateStudent(
        address: json["address"],
        dateOfBirth: json["dateOfBirth"],
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        photo: json["photo"],
        sex: json["sex"],
    );

    Map<String, dynamic> toMap() => {
        "address": address,
        "dateOfBirth": dateOfBirth,
        "id": id,
        "name": name,
        "phone": phone,
        "photo": photo,
        "sex": sex,
    };
}

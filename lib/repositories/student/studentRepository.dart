import 'dart:convert';

import 'package:flutter_app_pms/model/student/CreateStudent.dart';
import 'package:flutter_app_pms/model/student/student.dart';
import 'package:http/http.dart' as http;

// Repository
// Future<bool> createStudents(CreateStudent createStudent) async {
//   final response = await http.post(Uri.parse('http://127.0.0.1:8080/api/v1/student'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body:jsonEncode(createStudent.toMap()),
//   );

//   if (response.statusCode == 200) {
//     print('insert success');
      
//     return true;
//   } else {
//     print('insert field!');
//     // throw Exception('Failed to create Student.');
//     return false;
//   }
// }



// class StudentRepository {

//   // Mode
// StudentList studentFromMap(String str) => StudentList.fromMap(json.decode(str));

// // Repository
//   Future<StudentList> getStudentList(http.Client client) async {
//   final response = await client
//       .get(Uri.parse('http://127.0.0.1:8080/api/v1/student/'));
//   return compute(studentFromMap, response.body);
//   }
// }



// // Mode
// StudentList studentFromMap(String str) => StudentList.fromMap(json.decode(str));

// // Repository
// Future<StudentList> getStudentList(http.Client client) async {
//   final response = await client
//       .get(Uri.parse('http://127.0.0.1:8080/api/v1/student/'));
//   return compute(studentFromMap, response.body);
// }



List<Student> students = [
  Student(
    id: "1",
    name: 'Yom Channa',
    address: 'Phone Penh',
    sex: 'Male',
    dateOfBirth: "1969-07-20",
    phone: '0977313670',
    photo: 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
  ),
   Student(
    id: "2",
    name: 'Yan Rithy',
    address: 'Phone Penh',
    sex: 'Male',
    dateOfBirth: "1969-07-20",
    phone: '0977313670',
    photo: 'https://www.interconrooster.com/wp-content/uploads/2018/08/10-2.jpg',
  ),
   Student(
    id: "3",
    name: 'Yan Rithy',
    address: 'Phone Penh',
    sex: 'Male',
    dateOfBirth: "1969-07-20",
    phone: '0977313670',
    photo: 'https://placeimg.com/640/480/any',
  ),
];
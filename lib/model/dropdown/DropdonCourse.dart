
import 'package:flutter_app_pms/configuration/apiService.dart';
import 'package:http/http.dart' as http;

class DropdownCourseModel extends ApiService {
  String id;
  String name;  

  DropdownCourseModel({this.name, this.id});

  factory DropdownCourseModel.fromJson(Map<String, dynamic> json) {
    return DropdownCourseModel(
      name: json["name"],
      id: json["id"],
    );
  }

  List<DropdownCourseModel> jsonList(Map<String, dynamic> json, String jName) {
    if (json[jName] == null) {
      return new List<DropdownCourseModel>();
    }
    return List<DropdownCourseModel>.from(
      json[jName].map(
        (e) => DropdownCourseModel.fromJson(e),
      ),
    );
  }

// Repos
  Future<http.Response> getCodeName(String url) async {
        return await getNoToken(url: url);
     }
  }

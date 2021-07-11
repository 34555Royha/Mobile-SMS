import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

    Future getImage({ImageSource imageSource = ImageSource.gallery}) async {
    File file = await ImagePicker.pickImage(
    source: imageSource, maxHeight: 600, maxWidth: 800);
    return file;
    }

const String fullServerPath = "http://127.0.0.1:8080/api/v1/student/upload";

    enum UploadStatus { Successful, Failed}

      Future<UploadStatus> uploadFile(File file) async{
      Uint8List byteFile = file.readAsBytesSync();
      String base64Image = await compute(base64Encode, byteFile);
      String fileName = file.path.split("/").last;
      FormData formData = FormData.fromMap({
      "file" : MultipartFile.fromString(base64Image),
      });
      Response response = await Dio().post(fullServerPath, data: formData);
      if(response.statusCode == 200){
      print(response.data);
      return UploadStatus.Successful;
      }
      else{
      print("Error: ${response.statusCode}");
      return UploadStatus.Failed;

      }
    

 
  }

    //  Future<UploadStatus> uploadFiles(File file) async {

    //    Uint8List byteFile = file.readAsBytesSync();
    //    String base64Image = await compute(base64Encode, byteFile);
    //    String fileName = file.path.split("/").last;
    //    print(fileName);

    //    FormData formData = FormData.fromMap({
    //      "name" : fileName,
    //      "file" : MultipartFile.fromString(base64Image),
    //    });
    //    Response response = await Dio().post(fullServerPath, data: formData);

    //    if(response.statusCode == 200){
    //      print(response.data);
    //      return UploadStatus.Successful;
    //    }
    //    return UploadStatus.Failed;
    //  }
    


    
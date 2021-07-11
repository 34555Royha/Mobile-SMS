import 'dart:convert';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pms/configuration/CustomerForm.dart';
import 'package:flutter_app_pms/configuration/apiService.dart';
import 'package:flutter_app_pms/configuration/uploadFile.dart';
import 'package:flutter_app_pms/model/auth/register.dart';
import 'package:image_picker/image_picker.dart';

String responses;
// Repository
Future<bool> createStudents(Register register) async {

  final response = await ApiService().postAPINoToken(url: 'http://127.0.0.1:8080/register', body: jsonEncode(register.toMap()));
  responses = json.decode(response.body)['message'];
  if (response.statusCode == 200) {
    print('Register Success');
    return true;
  } else {
     print('Register Failed!');
    // throw Exception('Failed to create Student.');
    return false;
  }
}


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

    TextEditingController username = new TextEditingController();
    TextEditingController password = new TextEditingController();
    TextEditingController confirmpassword = new TextEditingController();


  final _scaffoldState = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

  void  functionRegister() async{
    Register register;
    if(password.text != confirmpassword.text) {
       CoolAlert.show(
                context: context,
                type: CoolAlertType.warning,
                title: "Change Password",
                text: "Invalid Confirm Password",
                onConfirmBtnTap: () {
                  Navigator.pop(context);
                },
              );

       
    }else{
       register  = Register(
          username: username.text,
          password: password.text,
          profileImg: '',
          status: true,
        );
         if(await createStudents(register)){
          print("Register Success");
           CoolAlert.show(
                  context: context,
                  type: CoolAlertType.success,
                  title: "Register Success",
                  text: responses,
                  onConfirmBtnTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }).then((value) => {
                  });
        }else{
           CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            title: "Register Failed",
            text: responses,
          );
          print("Register Failed!");
        }
        print(json.encode(register.toMap()));
    }


    }

    File _file;
      void opemCamera () async{
        File file = await getImage(imageSource: ImageSource.camera);
        if(file != null) {
          setState(() {
            _file = file;
          });
           print('Image path: ${_file.path}');
        }
       
      }
      void opemImage () async{
           File file = await getImage();
        if(file != null) {
          setState(() {
            _file = file;
          });
          print('Image path: ${_file.path}');
        }
        
      }
      void uploadImage () async{
        if(_file != null) {
          UploadStatus uploadStatus = await uploadFile(_file);
          if(uploadStatus == UploadStatus.Successful){
            print("File Uploaded successs");
          }else{
             print("File Uploaded failed");
          }
        }else{
           print("No file, Please select file");
        }
      }
      
        final title = Text(
      'Register',
      style: TextStyle(
          color: Colors.red[900], fontWeight: FontWeight.bold, fontSize: 30),
      textAlign: TextAlign.center,
    );

    final txtUsername = CustomerForm.textBox(
      username,
      'Username',
      validate: true,
      keyboardType: TextInputType.number,
    );

    final txtPasswrod = CustomerForm.textBox(
      password,
      'Password',
      validate: true,
      keyboardType: TextInputType.emailAddress,
    );

    final txtConPasswrod = CustomerForm.textBox(
      confirmpassword,
      'Confirm Password',
      validate: true,
      keyboardType: TextInputType.emailAddress,
    );


          final Padding btnSubmit = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: CustomerForm.borderRadius(),
        ),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            functionRegister();
          }
        },
        padding: EdgeInsets.all(12),
        color: Colors.blue[900],
        child: Text('Register Now', style: TextStyle(color: Colors.white)),
      ),
    );
    final Padding btnCancel = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: CustomerForm.borderRadius(),
        ),
        onPressed: () async {
          Navigator.pop(context);
        },
        padding: EdgeInsets.all(12),
        color: Colors.red[900],
        child: Text('Cancel', style: TextStyle(color: Colors.white)),
      ),
    );

     return Scaffold(
      key: _scaffoldState,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("New User"),
        backgroundColor: Colors.blue[900],
        actions: <Widget>[
          IconButton(icon: Icon(Icons.camera_alt), onPressed: (){
            opemImage();
          }),
          IconButton(icon: Icon(Icons.image), onPressed: (){
            opemImage();
          }),
          IconButton(icon: Icon(Icons.file_upload), onPressed: (){
            uploadImage();
          }),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          children: <Widget>[
             SizedBox(height: 60.0),
            title,
            SizedBox(height: 40.0),
            txtUsername,
            SizedBox(height: 10.0),
            txtPasswrod,
            SizedBox(height: 10.0),
            txtConPasswrod,
            SizedBox(height: 10.0),
            Row(
            children: <Widget>[
              Expanded(child: btnCancel),
              SizedBox(width: 5.0),
              Expanded(child: btnSubmit),
            ],
          ),
          ],
        ),
      ),
    );
  }
}
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pms/configuration/BaseUrl.dart';
import 'package:flutter_app_pms/configuration/CustomerForm.dart';
import 'package:flutter_app_pms/configuration/apiService.dart';
import 'package:flutter_app_pms/model/student/list.dart';
import 'package:flutter_app_pms/model/user/login.dart';
import 'package:flutter_app_pms/model/user/user.dart';
import 'package:flutter_app_pms/view/auth/forgetpassword.dart';
import 'package:flutter_app_pms/view/auth/register.dart';
import 'package:flutter_app_pms/view/home/Index.dart';
import 'package:http/http.dart' as http;
String apiKey;
// Repository
StudentList studentFromMap(String str) => StudentList.fromMap(json.decode(str));

// Future<bool> getStudentList() async {
//   final response = await ApiService().getAPIWithToken(url: urlAPI+'student/');
//   if(response.statusCode == 200) {
//     return true;
//   }else{
//     return false;
//   }
// }

//Testing

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin , ApiService{
       User user = new User();
  // AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // _controller = AnimationController(vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    TextEditingController _txtUsername = TextEditingController();
    TextEditingController _txtPassword = TextEditingController();

 final _formKey = GlobalKey<FormState>();

//  final title = Text(
//       'Login',
//       style: TextStyle(
//           color: Colors.red[900], fontWeight: FontWeight.bold, fontSize: 30),
//       textAlign: TextAlign.center,
//     );
 final title = Image.asset(
                        'assets/key.png',
                        // height: 300,
                        // width: 300,
                      );



  var txtUsername = CustomerForm.textBox(
      _txtUsername,
      'Username',
      validate: true,
    );
   var txtPassword = CustomerForm.textBox(
      _txtPassword,
      'Password',
      validate: true,
      obscureText: true,
    );

   final forgotLabel = FlatButton(
      child: Text(
        'Forget password',
        style: TextStyle(color: Colors.blue[900]),
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ForgetPassword()));
      },
    );

        var btnLoging = CustomerForm.raisedButton(
      'Login',
      color: Colors.blue[900],
      onPressed: () async {
        if (_formKey.currentState.validate()) {
      Login login = Login(username: _txtUsername.text,password: _txtPassword.text);
      
      print(jsonEncode(login.toMap()));

      //  Cal Method for push data to server
    final rsp = await user.appLogin(login);
   if (rsp.statusCode == 200) {
            user = User.fromMap(jsonDecode(rsp.body));
            print(user.toMap());

            //Set Token
            setApiKey(user.user.apiKey);
            setPrefs("id", user.user.id.toString());
            setPrefs("username", user.user.username);
            setPrefs("profileImg", user.user.profileImg.toString());
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          } else {
            CustomerForm.snackBar(
              _formKey.currentContext,
              jsonDecode(rsp.body)["message"],
            );
          }


          // apiKey = 'Basic ' + base64Encode(utf8.encode(_txtUsername.text+':'+_txtPassword.text));
          // if(await getStudentList() ==  true){
          //   print("Login success");
          //   print("Login : "+ getStudentList().toString());
          //     FocusScope.of(context).requestFocus(FocusNode());
          //    Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => HomePage(),
          //     ),
          //   );
          // }else{
          //   print("Login Failed");
          // }

          // // print( 'Basic ' + base64Encode(utf8.encode('$username:$password'));
          // print( 'Basic ' + base64Encode(utf8.encode(_txtUsername.text+':'+_txtPassword.text)));
          // // FocusScope.of(context).requestFocus(FocusNode());
          // //  Navigator.push(
          // //     context,
          // //     MaterialPageRoute(
          // //       builder: (context) => HomePage(),
          // //     ),
          // //   );
        }
      },
    );

    final signupLabel = FlatButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegisterPage()));
      },
      child: Text(
        'New User? Register',
        style: TextStyle(color: Colors.blue[900]),
      ),
    );

  

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            children: <Widget>[
              title,
              SizedBox(height: 40.0),
              txtUsername,
              SizedBox(height: 10.0),
              txtPassword,
              SizedBox(height: 10.0),
              forgotLabel,
              SizedBox(height: 10.0),
              btnLoging,
              signupLabel
            ],
          ),
        ),
      ),
    );
  }
}
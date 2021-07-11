import 'package:flutter/material.dart';
import 'package:flutter_app_pms/configuration/CustomerForm.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword>
    with SingleTickerProviderStateMixin {
      final _formKey = GlobalKey<FormState>();

  // AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    // _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _txtUsername = TextEditingController();
    var _txtEmail = TextEditingController();

    final title = Text(
      'Forget Password',
      style: TextStyle(
          color: Colors.red[900], fontWeight: FontWeight.bold, fontSize: 30),
      textAlign: TextAlign.center,
    );

    final txtUsername = CustomerForm.textBox(
      _txtUsername,
      'Username',
      validate: true,
    );

    final txtEmail = CustomerForm.textBox(
      _txtEmail,
      'Email',
      validate: true,
    );

        final Padding btnSubmit = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: CustomerForm.borderRadius(),
        ),
        onPressed: () async {
          // if (_formKey.currentState.validate()) {
          //   // functionUpdate();
          // }
        },
        padding: EdgeInsets.all(12),
        color: Colors.blue[900],
        child: Text('Submit', style: TextStyle(color: Colors.white)),
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
        color: Colors.yellow[700],
        child: Text('Cancel', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            children: [
              title,
              SizedBox(height: 40.0),
              txtUsername,
              SizedBox(height: 10.0),
              txtEmail,
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
      ),
    );
  }
}
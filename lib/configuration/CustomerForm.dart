import 'package:flutter/material.dart';

class CustomerForm {

  // Text Field
    static textFormFieldDecoration(
    String labelText, {
    Icon icon,
  }) {
    return InputDecoration(
      labelText: labelText,
      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
      ),
      prefix: icon,
    );
  }

    static textBox(
    TextEditingController cnt,
    String labelText, {
    bool readOnly = false,
    bool validate = false,
    GestureTapCallback onTap,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: cnt,
      readOnly: readOnly,
      obscureText: obscureText,
      decoration: CustomerForm.textFormFieldDecoration(labelText),
      onTap: onTap,
      validator: (value) {
        if (validate) {
          if (value == null || value.isEmpty) {
            return '$labelText is required!';
          } else {
            return null;
          }
        }
        return null;
      },
      autovalidateMode: validate ? AutovalidateMode.onUserInteraction : null,
    );
  }

 static borderRadius() {
    return BorderRadius.circular(7);
  }

  static raisedButton(
    String text, {
    Color color = Colors.blueGrey,
    VoidCallback onPressed,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        onPressed: onPressed == null ? () {} : onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: CustomerForm.borderRadius(),
        ),
        padding: EdgeInsets.all(12),
        color: color,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

    static textFormFieldDecorationPrefixIcon(
      {String labelText, Icon prefixIcon}) {
    return InputDecoration(
      labelText: labelText,
      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      fillColor: Colors.black,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
      ),
      prefixIcon: prefixIcon,
    );
  }

    static dropdownSearchDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        // gapPadding: 10.0,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
    );
  }

  static searchBoxDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
    );
  }

    static snackBar(BuildContext context, String msg) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          // textAlign: TextAlign.center,
        ),
      ),
    );
  }

}
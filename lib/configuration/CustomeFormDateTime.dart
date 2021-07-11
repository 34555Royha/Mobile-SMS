import 'package:flutter/material.dart';

class CustomeFormDateTime {

 Future<DateTime> datePicker(BuildContext context, DateTime dt) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: dt,
      firstDate: DateTime(2015, 1),
      lastDate: DateTime(2100),
    );

    return picked;

    // if (picked == null) {
    //   return dt;
    // } else {
    //   return picked;
    // }
  }

  Future<TimeOfDay> selectTime(BuildContext context, TimeOfDay time) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: time,
    );
    if (picked == null) {
      return time;
    } else {
      return picked;
    }
  }

  void alert(BuildContext context, String msg) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
        ),
        duration: Duration(seconds: 5),
      ),
    );
  }

}
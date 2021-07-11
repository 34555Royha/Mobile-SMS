import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pms/configuration/BaseUrl.dart';
import 'package:flutter_app_pms/configuration/apiService.dart';
import 'package:flutter_app_pms/model/student/list.dart';
import 'package:flutter_app_pms/view/student/Detail.dart';
import 'package:flutter_app_pms/view/student/Create.dart';
import 'package:flutter_app_pms/view/student/Search.dart';
import 'package:flutter_app_pms/view/student/Update.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Repository
StudentList studentFromMap(String str) => StudentList.fromMap(json.decode(str));

Future<StudentList> getStudentList() async {
  final response = await ApiService().getAPIWithToken(url: urlAPI+'student/');
  return compute(studentFromMap, response.body);
}


String responses;
// Repository Delete
Future<bool> deleteStudents(String id) async {
  final response = await ApiService().deleteWithToken(url: urlAPI+'student/'+id);
  responses = json.decode(response.body)['message'];
  if (response.statusCode == 200) {
    print('Delete success');
    return true;
  } else {
    print('Delete field!');
    // throw Exception('Failed to create Student.');
    return false;
  }
}

class StudentPage extends StatefulWidget {
  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {

StudentList studentList;

  @override
  Widget build(BuildContext context) {

    initState() {
      print(urlAPI+'student/');
      getStudentList();
      super.initState();
    }

    Future<void> functionDelete(String id) async {
    return await CoolAlert.show(
      context: context,
      type: CoolAlertType.confirm,
      title: "Delete",
      backgroundColor: Colors.red[900],
      confirmBtnColor: Colors.blue[900],
      text: "Would you like to Delete?",
      onConfirmBtnTap: () async {
        if (await deleteStudents(id)) {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            title: "Delete",
            text: responses,
            onConfirmBtnTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          );
          setState(() {
          });
        } else {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            title: "Delete Failed!",
            text: "You can not delete, because this record has relationship to other recortd",
            onConfirmBtnTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          );
        }
      },
    );
  }
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Student'),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StudentSearchPage()));
              }),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => StudentNew()));
              })
        ],
      ),
      body:  RefreshIndicator(
              onRefresh: () async{ 
                setState(() {
                  getStudentList();
                });
               },
              child: Container(
                child: FutureBuilder<StudentList>(
                    future: getStudentList(),
                        builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                            if (snapshot.hasData) {
                              studentList = snapshot.data;
                             return Container(
                              decoration: BoxDecoration(
                                      color: Colors.grey[200]
                                    ),
                              child: ListView.builder(
                                    padding: const EdgeInsets.all(8),
                                    itemCount: studentList.students.length,
                                    itemBuilder: (BuildContext context, int index) {
                                    return Slidable(
                                      key: ValueKey(index),
                                      actionPane: SlidableDrawerActionPane(),
                              actions: <Widget>[
                                IconSlideAction(
                                  caption: 'Update',
                                  color: Colors.indigo,
                                  icon: Icons.verified_outlined,
                                  onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => StudentUpdate(id: studentList.students[index].id,)));
                                  },
                                ),
                                IconSlideAction(
                                  caption: 'Delete',
                                  color: Colors.red,
                                  icon: Icons.clear,
                                  onTap: () {
                                    functionDelete(studentList.students[index].id);
                                   print("id "+studentList.students[index].id);
                                  },
                                ),
                              ],
                              dismissal: SlidableDismissal(
                                child: SlidableDrawerDismissal(),
                              ),
                  child: Card(
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                  onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => StudentDetailPage(int.parse(studentList.students[index].id.toString()))));
                    // print('object');
                  },
                              child: Column(
                    children: [
                      ListTile(
                        leading: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                       Container(
                                         width: 40,
                                         height: 40,
                                         decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover, image: NetworkImage("$baseUrlAPi"+studentList.students[index].photo.toString())),
                                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                        color: Colors.redAccent,
                                      ),
                                       ),
                                    ],
                                  ),
                        // title: const Text('Card title 1'),
                        title: Text(studentList.students[index].name.toString()),
                      ),
                     Image.network(
                              "$baseUrlAPi"+studentList.students[index].photo.toString(),
                              width: double.maxFinite,
                              height: 200,
                              fit:BoxFit.fill
                          ),
                          SizedBox(height: 10,),
                          ListTile(
                                  isThreeLine: true,
                                  subtitle: Container(
                                    width: 100,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: 5,),
                                        Text('ID: ' +studentList.students[index].id.toString()),
                                        Text('Name: ' +studentList.students[index].name.toString()),
                                        Text('Address: ' +studentList.students[index].address.toString()),
                                        Text('Sex: ' + studentList.students[index].sex.toString()),
                                         Text('Date Of Birth: ' + studentList.students[index].dateOfBirth),
                                          Text('Phone: ' + studentList.students[index].phone.toString()),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    // getOvertimeReqDetail(
                                    //     searchOvertimeReq[index].id);
                                  },
                                ),
                    ],
                  ),
              ),
            ),
                );
               }
              ),
        );
                            } else {
                              print(snapshot.data);
                                return Center(
                                child: Text("No Data"),
                                );
                                }
                                } else {
                                return Center(
                                child: SpinKitDualRing(
                                    color: Colors.blue[900],
                                    size: 61.0,),
                            );
                        }
                    },
                ),
        ),
      ) 
    );
  }
}


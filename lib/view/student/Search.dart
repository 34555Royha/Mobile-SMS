import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pms/configuration/BaseUrl.dart';
import 'package:flutter_app_pms/configuration/apiService.dart';
import 'package:flutter_app_pms/model/student/list.dart';
import 'package:flutter_app_pms/view/student/Detail.dart';
import 'package:flutter_app_pms/view/student/Update.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Repository
StudentList studentFromMap(String str) => StudentList.fromMap(json.decode(str));
Future<StudentList> getStudentList() async {
  final response = await ApiService().getAPIWithToken(url: urlAPI+'student/');
  return compute(studentFromMap, response.body);
}

class StudentSearchPage extends StatefulWidget {
  @override
  _StudentSearchPageState createState() => _StudentSearchPageState();
}

class _StudentSearchPageState extends State<StudentSearchPage> {
  String statusCode = "200";
  // StudentList studentList;
  List<StudentElement> studentList;
  List<StudentElement> searchstudents = [];

      Future<void> functionDelete() async {
    return await CoolAlert.show(
      context: context,
      type: CoolAlertType.confirm,
      title: "Delete",
      text: "Would you like to Delete?",

      
      onConfirmBtnTap: () async {
        if (statusCode == "200") {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            title: "Delete",
            text: "Completed Successfully!",
            onConfirmBtnTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          );
          //Set Current State
          setState(() {});

          //Success => should route to list screen
        } else {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            title: "Delete",
            text: "Error",
          );
        }
      },
    );
  }
  

  @override
  Widget build(BuildContext context) {
    


      return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Container(
            padding: EdgeInsets.only(left: 15, right: 5),
            alignment: Alignment.centerLeft,
            height: 40,
            //  margin: EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              onChanged: (String text) {
               if(text == ""||text == " "||text == "   "||text == "    "||text.isEmpty){
                 setState(() {
                   searchstudents = [];
                 });
               }else{
                  setState(() {
                  searchstudents = studentList
                      .where((element) => element.name
                          .toLowerCase()
                          .contains(text.toLowerCase()))
                      .toList();
                });
               }
              },
              decoration: InputDecoration(
                hintText: "Search...",
                border: InputBorder.none,
              ),
            )),
      ),
      body: _buildBody,
    );
  }

  get _buildBody {
    return  RefreshIndicator(
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
                              studentList = snapshot.data.students;
                             if(searchstudents.length == 0){
                               return Center(
                                child: Text("Search not found!"),
                                );
                             }else{
                               return Container(
                              decoration: BoxDecoration(
                                      color: Colors.grey[200]
                                    ),
                              child: ListView.builder(
                                    padding: const EdgeInsets.all(8),
                                    itemCount: searchstudents.length,
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
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => StudentUpdate()));
                                  },
                                ),
                                IconSlideAction(
                                  caption: 'Delete',
                                  color: Colors.red,
                                  icon: Icons.clear,
                                  onTap: () {
                                    functionDelete();
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
                    print("$baseUrlAPi/"+searchstudents[index].photo);
                     Navigator.push(context, MaterialPageRoute(builder: (context) => StudentDetailPage(int.parse(searchstudents[index].id.toString()))));
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
                                            fit: BoxFit.cover, image: NetworkImage("$baseUrlAPi"+searchstudents[index].photo.toString())),
                                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                        color: Colors.redAccent,
                                      ),
                                       ),
                                    ],
                                  ),
                        // title: const Text('Card title 1'),
                        title: Text(searchstudents[index].name.toString()),
                      ),
                     Image.network(
                              "$baseUrlAPi"+searchstudents[index].photo.toString(),
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
                                        Text('ID: ' +searchstudents[index].id.toString()),
                                        Text('Address: ' +searchstudents[index].address.toString()),
                                        Text('Sex: ' + searchstudents[index].sex.toString()),
                                         Text('Date Of Birth: ' + searchstudents[index].dateOfBirth),
                                          Text('Phone: ' + searchstudents[index].phone.toString()),
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
                             }
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
      );
  }
}
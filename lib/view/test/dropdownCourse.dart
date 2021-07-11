import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_pms/model/dropdown/DropdonCourse.dart';
import 'package:http/http.dart' as http;

class DropdownCoursePage extends StatefulWidget {
  @override
  _DropdownCoursePageState createState() => _DropdownCoursePageState();
}

class _DropdownCoursePageState extends State<DropdownCoursePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

    // Repository

//Start Dropdown Category Repository
     DropdownCourseModel dropdownCourseModel = new DropdownCourseModel();
     List<DropdownCourseModel> dropdownCourseList = new List<DropdownCourseModel>();
     Future getDropdownCourse() async {
    http.Response rsp = await dropdownCourseModel.getCodeName('http://127.0.0.1:8080/api/v1/course/dropdown');
    dropdownCourseList = dropdownCourseModel.jsonList(json.decode(rsp.body), "categories");}
//End Dropdown Category Repository

  @override
  void initState(){
    super.initState();
    _controller = AnimationController(vsync: this);
    getDropdownCourse();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
              onRefresh: () async{ 
                setState(() {
                  getDropdownCourse();
                });
               },
              child: Container(
                    color: Colors.grey[200],
                    child: ListView.builder(
                    itemCount: dropdownCourseList.length,
                    itemBuilder: (context, index) {
                    return Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    color: Colors.white,
                    child: Row(
                    children: <Widget>[
                    Container(
                                width: 80,
                                height: 80,
                                 decoration: BoxDecoration(
                                    color: const Color(0xff7c94b6),
                                    image: const DecorationImage(
                                      image: NetworkImage('https://z-p3-scontent.fpnh5-3.fna.fbcdn.net/v/t1.6435-9/144763261_462089518285722_2930095051505626269_n.jpg?_nc_cat=105&ccb=1-3&_nc_sid=174925&_nc_eui2=AeGs8SrQotJKu0niLuZchaxFzXQSgjdH_dfNdBKCN0f915QN-Ht59zencetoEQp4ylXtJ-GZcx5onhLtP45NKk2T&_nc_ohc=VhQGjRRvUFMAX_kL2IF&_nc_ht=z-p3-scontent.fpnh5-3.fna&oh=22e0545a8b7567b0fbca4cc3df7a9d4a&oe=60D10723'),
                                      fit: BoxFit.cover,
                                    ),
                                    shape: BoxShape.circle,
                            )),
                     Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                    "Dropdown Category",
                    style: TextStyle(fontSize: 20.0),
                    ),
                    ),
                    Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                    "id: "+ dropdownCourseList[index].id.toString(),
                    style: TextStyle(fontSize: 15.0),
                    ),
                    ),
                    Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                    "name: "+ dropdownCourseList[index].name.toString(),
                    style: TextStyle(fontSize: 15.0),
                    ),
                    ),
                      ],
                    )
                    ],
                    ),
                    );
                    }),
                    ),
      ),
    );
  }
}
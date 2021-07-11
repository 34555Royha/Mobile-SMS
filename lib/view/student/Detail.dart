import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_pms/configuration/BaseUrl.dart';
import 'package:flutter_app_pms/configuration/apiService.dart';
import 'package:flutter_app_pms/model/student/getById.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


// Repository
GetById getByIdFromMap(String str) => GetById.fromMap(json.decode(str));
Future<GetById> getById(String id) async {
  final response = await ApiService().getAPIWithToken(url: urlAPI+'student/'+id);
  return compute(getByIdFromMap, response.body);
}

class StudentDetailPage extends StatefulWidget {
  int id;  
  StudentDetailPage(this.id);

  @override
  _StudentDetailPageState createState() => _StudentDetailPageState();
}

class _StudentDetailPageState extends State<StudentDetailPage> {


  GetById getStudentById;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar,
      body: _buildBody,
    );
  }

  get _buildAppBar {
    return AppBar(
      backgroundColor: Colors.blue[900],
      title: Text('Student Detail'),
    );
  }
  
  get _buildBody {
    int id = widget.id;
    return Container(
    child: FutureBuilder<GetById>(
      future: getById(id.toString()),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasData){
            getStudentById = snapshot.data;
            return RefreshIndicator(
                 onRefresh: () { 
              setState(() {
                  getById(id.toString());
                 });
                           },
                          child: ListView(
       children: [
         Container(
           decoration: BoxDecoration(),
              clipBehavior: Clip.antiAlias,
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
                            fit: BoxFit.cover, image: NetworkImage("$baseUrlAPi"+getStudentById.student.photo.toString())),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        color: Colors.redAccent,
                      ),
                       ),
                    ],
                  ),
                        // title: const Text('Card title 1'),
                        title: Text(getStudentById.student.name.toString()),
                        subtitle: Text('Marko Vidojkovic'),
                      ),
                     Image.network(
              "$baseUrlAPi"+getStudentById.student.photo.toString(),
              width: double.maxFinite,
              // height: 200,
              fit:BoxFit.cover
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
                        Text('ID: ' +getStudentById.student.id.toString()),
                        Text('Address: ' +getStudentById.student.address.toString()),
                        Text('Sex: ' + getStudentById.student.sex.toString()),
                         Text('Date Of Birth: ' + getStudentById.student.dateOfBirth),
                          Text('Phone: ' + getStudentById.student.phone.toString()),
                          SizedBox(height: 10,),
                          Text('Marko Vidojkovic ',style: TextStyle(fontSize: 30,color: Colors.black)),
                          SizedBox(height: 5,),
                               Text("            Armenia’s ex-president seeks to lead again https://eurasianet.org/armenias-ex-president-seeks-to-lead-again … Robert Kocharyan is trying for a unique feat in the post-Soviet space: a return to power. And he’s become the top opposition contender ahead of the June 20 elections. @MejlumyanAni and I report."+
                          "Armenia’s ex-president seeks to lead again https://eurasianet.org/armenias-ex-president-seeks-to-lead-again … Robert Kocharyan is trying for a unique feat in the post-Soviet space: a return to power. And he’s become the top opposition contender ahead of the June 20 elections. @MejlumyanAni and I report."+
                          "            Armenia’s ex-president seeks to lead again https://eurasianet.org/armenias-ex-president-seeks-to-lead-again … Robert Kocharyan is trying for a unique feat in the post-Soviet space: a return to power. And he’s become the top opposition contender ahead of the June 20 elections. @MejlumyanAni and I report."+
                          "Armenia’s ex-president seeks to lead again https://eurasianet.org/armenias-ex-president-seeks-to-lead-again … Robert Kocharyan is trying for a unique feat in the post-Soviet space: a return to power. And he’s become the top opposition contender ahead of the June 20 elections. @MejlumyanAni and I report."+
                          " Armenia’s ex-president seeks to lead again https://eurasianet.org/armenias-ex-president-seeks-to-lead-again … Robert Kocharyan is trying for a unique feat in the post-Soviet space: a return to power. And he’s become the top opposition contender ahead of the June 20 elections. @MejlumyanAni and I report.",style: TextStyle(fontSize: 15,color: Colors.black)),
                     
                           
                         
                          ],
                    ),
                  ),
                  // onTap: () {
                  //   // getOvertimeReqDetail(
                  //   //     searchOvertimeReq[index].id);
                  // },
                ),
                    ],
                  ),
          ),
       ],
      ),
            );
          }else {
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
    )
      );
  }
}


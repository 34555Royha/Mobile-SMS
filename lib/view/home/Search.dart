import 'package:flutter/material.dart';
import 'package:flutter_app_pms/model/home/menu.dart';
import 'package:flutter_app_pms/repositories/home/MenuRepository.dart';
import 'package:flutter_app_pms/view/auth/login.dart';
import 'package:flutter_app_pms/view/student/Index.dart';

class MenuSearch extends StatefulWidget {
  @override
  _MenuSearchState createState() => _MenuSearchState();
}

class _MenuSearchState extends State<MenuSearch>
    with SingleTickerProviderStateMixin {

      List<Menu> listMenu = menus;
       List<Menu> searchMenu = [];


        AnimationController _controller;
       final _scaffoldKey = GlobalKey<ScaffoldState>();
      

     


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final snackBar = SnackBar(
    //     content: Text("Gesture Tapped"),
    //     duration: Duration(milliseconds: 5000),
    //     action: SnackBarAction(label: "Undo", 
    //     onPressed: ()=>debugPrint("Undo Click")),
    //     );
    //     Scaffold.of(context).showSnackBar(snackBar);

     return Scaffold(
      key: _scaffoldKey,
      body: _buildBody,
      appBar: _buildAppBar,
      // drawer: _buildNavBar,
    );
  }

  
  //Local Method
  void menuClick(String menu) {
    print(menu);
    if (menu == "student") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => StudentPage()));
    } 
    else if (menu == "myovertime") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => StudentPage()));
    } 
    else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
        content: Text("Unknow Mudle"),
        duration: Duration(milliseconds: 5000),
        action: SnackBarAction(label: "Undo", 
        onPressed: ()=>debugPrint("Undo Click")),
        ),
        // Scaffold.of(context).showSnackBar(snackBar);
      );
    }
  }

  get _buildBody {
    return GridView.count(
    crossAxisCount: 2, //2 => 2D
    padding: EdgeInsets.all(16.0),
    childAspectRatio: 8.0 / 9.0,
    children: List.generate(
      searchMenu.length, //Cound menu list
      (index) => Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: (){
                 menuClick(searchMenu[index].menu);
              },
                          child: Column(
                children: [
                  ListTile(
                    leading: searchMenu[index].icon,
                    // title: const Text('Card title 1'),
                    title: Text(searchMenu[index].title.toString()),
                    // subtitle: Text(
                    //   menus[index].subTitle.toString(),
                    //   style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    // ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      searchMenu[index].desc.toString(),
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  // ButtonBar(
                  //   alignment: MainAxisAlignment.start,
                  //   children: [
                  //     FlatButton(
                  //       textColor: const Color(0xFF6200EE),
                  //       onPressed: () {
                  //         // Perform some action
                  //         print('Action 1');
                  //       },
                  //       child: const Text('ACTION 1'),
                        
                  //     ),
                  //     FlatButton(
                  //       textColor: const Color(0xFF6200EE),
                  //       onPressed: () {
                  //         // Perform some action
                  //         print('Action 2');
                  //       },
                  //       child: const Text('ACTION 2'),
                  //     ),
                  //   ],
                  // ),
                  // Image.asset('assets/card-sample-image.jpg'),
                  // Image.asset('assets/card-sample-image-2.jpg'),
                //  Image.network(
                //           menus[index].image.toString(),
                //           width: 300,
                //           height: 150,
                //           fit:BoxFit.fill

                //       ),
                ],
              ),
            ),
          ),
    ),
        );
  }

  get _buildAppBar {
    return  AppBar(
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
                   searchMenu = [];
                 });
               }else{
                  setState(() {
                  searchMenu = listMenu
                      .where((element) => element.title
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
      );
  }
}

 
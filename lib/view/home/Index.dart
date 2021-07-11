import 'package:flutter/material.dart';
import 'package:flutter_app_pms/configuration/BaseUrl.dart';
import 'package:flutter_app_pms/configuration/apiService.dart';
import 'package:flutter_app_pms/repositories/home/MenuRepository.dart';
import 'package:flutter_app_pms/view/auth/login.dart';
import 'package:flutter_app_pms/view/home/Search.dart';
import 'package:flutter_app_pms/view/student/Index.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin , ApiService {


        AnimationController _controller;
       final _scaffoldKey = GlobalKey<ScaffoldState>();

  var username;
  var id;
  var profileImg;
  void dataUserProfile() async {
     id = await getPrefs('id');
     username = await getPrefs('username');
     profileImg = await getPrefs('profileImg');
    setState(() {
    });
  }

       
  @override
  void initState() {
    print('$baseUrlAPi$profileImg');
    dataUserProfile();
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
      drawer: _buildNavBar,
    );
  }

  get _buildNavBar {
    return Drawer(
      child: Container(
        // color: Colors.blue[900],
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue[900],
              ),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 80,
                      //    color: Colors.pink,
                      child: Row(
                        children: [
                          Container(
                              width: 80,
                              height: 80,
                               decoration: BoxDecoration(
                                  color:  Color(0xff7c94b6),
                                  image:  DecorationImage(
                                    image: NetworkImage("$baseUrlAPi$profileImg"),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: BoxShape.circle,
                          )),
                              // decoration: BoxDecoration(
                              //   shape: BoxShape.circle,
                              //   // color: Colors.black,
                              // )),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '   $username',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '   Staff ID : $id',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 15),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      //       height: 30,
                      //   color: Colors.red,
                      child: Row(
                        children: [
                          Icon(
                            Icons.email,
                            color: Colors.white,
                            size: 17,
                          ),
                          Text('   yanrithy1235@gmail.com',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            // ListTile(
            //   leading: Icon(Icons.person, color: Colors.grey),
            //   title: Text(
            //     'My profile',
            //     style: TextStyle(color: Colors.grey),
            //   ),
            //   // onTap: () => {Navigator.of(context).pop()},
            //   onTap: () => {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => UserProfile(),
            //       ),
            //     ),
            //   },
            // ),
            ListTile(
              leading: Icon(Icons.lock_open, color: Colors.grey),
              title:
                  Text('Change password', style: TextStyle(color: Colors.grey)),
              onTap: () => {
                // Navigator.of(context).pop("") //Close Drawer
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => ChangePassword()))
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.language, color: Colors.grey),
            //   title: Text('Language', style: TextStyle(color: Colors.grey)),
            //   // onTap: () => {Navigator.of(context).pop()},
            //   onTap: () => {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => Language()))
            //   },
            // ),
            ListTile(
              leading: Icon(Icons.people, color: Colors.grey),
              title: Text('Contact us', style: TextStyle(color: Colors.grey)),
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.grey),
              title: Text('Settings', style: TextStyle(color: Colors.grey)),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.star_rate, color: Colors.grey),
              title: Text('Rate', style: TextStyle(color: Colors.grey)),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.grey),
              title: Text('Log out', style: TextStyle(color: Colors.grey)),
              onTap: () async {
                setApiKey("");
                // try {
                //   var body = json.encode({"name": x.fullName});
                //   final response = await post(urllogout, body);
                //   print('code = ${response.statusCode}');
                //   if (response.statusCode == 200) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                //   } else {
                //     _scaffoldKey.currentState.showSnackBar(
                //       SnackBar(
                //         content: Text(
                //           ErrorResponse.fromJson(jsonDecode(response.body))
                //               .errorDescription,
                //         ),
                //       ),
                //     );
                //   }
                // } catch (e) {
                //   _scaffoldKey.currentState.showSnackBar(
                //     SnackBar(
                //       content: Text(e.toString()),
                //     ),
                //   );
                // }
              },
            ),
          ],
        ),
      ),
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
        content: Text("Unknow Moudle"),
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
      menus.length, //Cound menu list
      (index) => Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: (){
                 menuClick(menus[index].menu);
              },
                          child: Column(
                children: [
                  ListTile(
                    leading: menus[index].icon,
                    // title: const Text('Card title 1'),
                    title: Text(menus[index].title.toString()),
                    // subtitle: Text(
                    //   menus[index].subTitle.toString(),
                    //   style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    // ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      menus[index].desc.toString(),
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
    return AppBar(
      title: Text("SMS"),
      backgroundColor: Colors.blue[900],
      actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: 'Search',
              color: Colors.white,
            ),
            onPressed: () async {
              //Action
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MenuSearch()));
            }),
        IconButton(
            icon: Icon(
              Icons.notifications,
              semanticLabel: 'Notification',
              color: Colors.white,
            ),
            onPressed: () async {
              //Point to Notification Page
            })

        // IconButton(icon: Icon(Icons.notifications, semanticLabel: 'search')),
      ],
    );
  }
}

 
import 'dart:convert';
// import 'package:badges/badges.dart';
// import 'package:car_washer/icons.dart';
// import 'package:car_washer/screens/editServicesScreen.dart';
// import 'package:car_washer/screens/historyScreen.dart';
// import 'package:car_washer/screens/pendingScreen.dart';
// import 'package:car_washer/screens/servicesScreen.dart';

import '../Helper/url_helper.dart' as url_helper;
// import 'package:car_washer/screens/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../Helper/request_helper.dart';
// import 'package:car_washer/screens/documentsScreen.dart';

// import 'chooseLocationScreen.dart';
// import 'screens/processingScreen.dart';
// import './globals.dart' as globals;

class myDrawer extends StatefulWidget {
  int index;
  myDrawer ({Key? key , required this.index}) : super(key: key);

  @override
  _myDrawerState createState() => _myDrawerState();

}

class _myDrawerState extends State<myDrawer> {


  void logout() async{
    final prefs = await SharedPreferences.getInstance();
    request_helper request_help = new request_helper();
    Uri uri = Uri.parse(constants.LOGOUT);
    Map<String, dynamic> body = {

      "device_id": await prefs.getString("identifier"),
      "Authorization": await prefs.getString("access_token"),

    };
    request_help.requestPost(uri, body).then((value) async {
      print(value.body);
      await prefs.setString("userjson", "");
      print(await prefs.getString("userjson"));
      Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
    }).onError((error, stackTrace){
      print(error.toString());
    });


  }







  List<bool> isSelected = List<bool>.filled(10, false);
  String dropdownvalue = 'En';
  late String? userjson= "";
  // Future<Map<String, dynamic>> getData() async{
  //   final prefs = await SharedPreferences.getInstance();
  //   userjson=await prefs.getString("userjson");
  //   print(json.decode(userjson!));
  //   return json.decode(userjson!);
  //
  //
  // }
  Map<String, dynamic> get = {"": ""};
  // String getuser(){
  //   getData().then((value){
  //     setState(() {
  //       get = value;
  //       print(get["access_token"]);
  //     });
  //
  //
  //   });
  //   return "";
  // }

  // List of items in our dropdown menu
  var items = [
    'En',
    'Ar',
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    // getuser();

  }
  url_helper.Constants constants = new url_helper.Constants();

  @override
  Widget build(BuildContext context) {

    String image = get["avatar"] != null?"${constants.getPhoto}${get["avatar"]}": "https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dmlld3xlbnwwfHwwfHw%3D&w=1000&q=80";
    isSelected[widget.index] = true;
    // TODO: implement build
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
// Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [

                DrawerHeader(

                  decoration: BoxDecoration(
                    color: Colors.blue.shade800,
                    image: DecorationImage(
                      image: AssetImage("assets/back.jpeg"),
                      fit: BoxFit.fill,

                    ),

                  ),



                  child: Container(

                    child: Column(

                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              child: CircleAvatar(
                                backgroundImage:
                                // get["avatar"] == null?
                                NetworkImage("https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dmlld3xlbnwwfHwwfHw%3D&w=1000&q=80"),
                                // NetworkImage(image),
                                radius: 6.5.h,
                                backgroundColor: Colors.transparent,
                              ),
                              // onTap:() {
                              //   Navigator.push(context, MaterialPageRoute(
                              //       builder: (context) =>
                              //           ProfileScreen(name: get["first_name"],
                              //             image: image,
                              //             email: get["email"],
                              //             number: get["mobile"],)));
                              // }
                            ),

                            // IconButton(onPressed: (){
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(name: get["first_name"], image: image,email: get["email"], number: get["mobile"],)));
                            // }, icon: Icon(Icons.account_circle_rounded,),iconSize: 100,),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 1.5.h,),

                                RichText(

                                  text: TextSpan(
                                    children: [

                                      WidgetSpan(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                          child: Icon(Icons.star, size: 15, color: Colors.yellowAccent,),
                                        ),
                                      ),
                                      //get["rating"]
                                      TextSpan(text: "5.00"),
                                    ],

                                  ),
                                ),
                                SizedBox(height: 1.2.h,),
                                // Text(get["status"] == null? "": "${get["status"]}", style: TextStyle(
                                //     color: get["status"] == "approved"?Colors.green.shade500:
                                //     get["status"] == "banned"?Colors.red.shade500:
                                //     Colors.orange.shade500,
                                //     fontSize: 15,
                                //
                                //     fontWeight: FontWeight.bold
                                //
                                // ))
                                Text("approved", style: TextStyle(
                                  color: Colors.green.shade500
                                ),)
                              ],
                            )
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          //${get["first_name"]}
                          child: Text("mohammed" ,style: TextStyle(
                            fontSize: 18,

                          ),),
                        )
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  onTap: () {
                    isSelected[0]? Navigator.pop(context):
                    Navigator.pushReplacementNamed(context, 'home');
                  },
                  selected: isSelected[0],
                  selectedColor: Colors.indigo.shade800,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                        height: 20,
                      ),
                    )
                  ],
                ),

                // ListTile(
                //   title: const Text('My Earning'),
                //   onTap: () {
                //     isSelected[2]? Navigator.pop(context):
                //     Navigator.pushReplacementNamed(context, 'earning');
                //   },
                //   selected: isSelected[2],
                // ),
                ListTile(
                  leading: Icon(Icons.pending),

                  title: const Text('Current Wash'),
                  onTap: () {
                    // isSelected[3]? Navigator.pop(context):
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PendingScreen(id: "${get["id"]}")));
                  },
                  selectedColor: Colors.indigo.shade800,
                  // trailing: Badge(
                  //   badgeColor: Colors.red,
                  //   showBadge: globals.text == 0? false: true,
                  //
                  //
                  // ),
                  selected: isSelected[3],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                        height: 20,
                      ),
                    )
                  ],
                ),
                ListTile(
                  // leading: Icon(MyIcons.aims_gesture),
                  title: const Text('Scheduled Wash'),
                  onTap: () {
                  //   isSelected[4]? Navigator.pop(context):
                  //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProcessingScreen(id: "${get["id"]}")));
                  },
                  selected: isSelected[4],
                  selectedColor: Colors.indigo.shade800,
                ),

                ListTile(
                  leading: Icon(Icons.history),

                  title: const Text('History'),
                  onTap: () {
                    // isSelected[1]? Navigator.pop(context):
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                    //     HistoryScreen(id: "${get["id"]}")));
                  },
                  selected: isSelected[1],
                  selectedColor: Colors.indigo.shade800,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                        height: 20,
                      ),
                    )
                  ],
                ),

                ListTile(
                  // leading: Icon(MyIcons.document_extension),

                  title: const Text('Payment'),
                  onTap: () {
// Update the state of the app.
// ...
//                     isSelected[5]? Navigator.pop(context):
//                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
//                         DocumentScreen(id: "${get["id"]}")));

                  },
                  selected: isSelected[5],
                  selectedColor: Colors.indigo.shade800,
                ),

                // ListTile(
                //   title: const Text('Notification'),
                //   onTap: () {
                //     isSelected[7]? Navigator.pop(context):
                //     Navigator.pushNamed(context, 'notification');
                //   },
                //   selected: isSelected[7],
                // ),
                // ListTile(
                //   title: const Text('Withdraw'),
                //   onTap: () {
                //     isSelected[8]? Navigator.pop(context):
                //     Navigator.pushReplacementNamed(context, 'withdraw');
                //   },
                //   selected: isSelected[8],
                // ),
                // ListTile(
                //   title: const Text('Help'),
                //   onTap: () {
                //     isSelected[9]? Navigator.pop(context):
                //     Navigator.pushReplacementNamed(context, 'help');
                //   },
                //   selected: isSelected[9],
                // ),

                ListTile(
                  title: const Text('Wallet'),
                  onTap: () {

                    // Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    //     EditServicesScreen(id: "${get["id"]}", Allservices: get,)));
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                        height: 20,
                      ),
                    )
                  ],
                ),
                ListTile(
                  leading: Icon(Icons.language),

                  title: const Text('Language'),
                  onTap: null,
                  trailing: DropdownButton(

                    // Initial Value
                    value: dropdownvalue,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ),



              ],
            ),
          ),
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onTap: (){
              logout();
            },
            tileColor: Colors.red,
            title: Text("Log out",style: TextStyle(
              color: Colors.white
            ),),
            trailing: Icon(Icons.logout),
          )
        ],
      ),
    );

  }
}
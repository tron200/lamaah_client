import 'dart:convert';

import 'package:lammah_client/rating.dart';

import '../Helper/request_helper.dart';
// import 'package:car_washer/bageIcon.dart';
import './myDrawer.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:car_washer/screens/documentsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import '../Helper/url_helper.dart' as url_helper;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:car_washer/globals.dart'as globals;
import 'package:location/location.dart';


class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  Location location = new Location();
  late LocationData _locationData;

  //latitude,  longitude
  static Map<String, dynamic> userDauserta = {"":""};
  String title = "";
  static double lat = 0;
  static double lon = 0;
  bool value_switch = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List userData =[];
  List<dynamic> Locations = [];
  late GoogleMapController mapController;
  Future<void> getCurrentLocation() async{
    _locationData = await location.getLocation();
  }
  // String washAsset = "assets/9055068_bxs_car_wash_icon.svg";
  // String earningAsset = "assets/7067452_earnings_provit_income_icon.svg";
  // String commisionAsset = "assets/4308025_capital_earnings_make_making_money_icon.svg";
  LatLng _center = LatLng(lat, lon);
  static double x = 0;
  static double y = 0;
  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    // x = double.parse(Locations[0]["latitude"]);
    // y = double.parse(Locations[0]["longitude"]);
    // print("Location: ${LatLng(x,y)}");
    //
    // Locations.forEach((element) {
    //   x = double.parse(element["latitude"]);
    //   y = double.parse(element["longitude"]);
    //   print("Location: ${LatLng(x,y)}");
    //   setState(() {
    //
    //     _markers.add(
    //         Marker(markerId: MarkerId('id-${element["id"]}'), position: LatLng(x,y),infoWindow: InfoWindow(
    //             title: "${element["first_name"]}"
    //         ))
    //     );
    //   });
    // });
  }

  request_helper requestHelp = new request_helper();
  url_helper.Constants url_help = new url_helper.Constants();
  bool isRedirect = false;

  // Future<void> getLocations() async{
  //   Uri uri = Uri.parse("${url_help.getProvidersLocations}275");
  //   Map<String, String> header = {'Content-Type': 'application/json; charset=UTF-8'};
  //
  //   requestHelp.requestGet(uri, header).then((response){
  //     if(response.statusCode == 200){
  //       setState(() {
  //         Locations = json.decode(response.body);
  //         // print(Locations);
  //       });
  //     }
  //   });
  // }

  // Future<void> setStatus(String Status) async{
  //   Uri uri = Uri.parse(url_help.setStatus);
  //   Map <String, dynamic> body = {
  //     "provider_id": userDauserta["id"],
  //     "service_status": Status
  //   };
  //   requestHelp.requestPost(uri, body).then((response){
  //     if(response.statusCode == 200){
  //       print("Done");
  //     }else{
  //       print(response.statusCode);
  //     }
  //   });
  // }
  List<dynamic> _services = [];

  Future<void> getProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    print(await prefs.getString("access_token"));
    Uri url = Uri.parse(url_help.USER_PROFILE_API);
    var token = await prefs.getString("access_token");
    Map<String, String> header = {
      "X-Requested-With": "XMLHttpRequest",
      "Authorization": "Bearer $token"} ;

    requestHelp.requestGet(url,header).then((responce) async {
      if(responce.statusCode == 200) {
        final String? user = responce.body;
        setState(() {
          userDauserta = json.decode(user!);
          // print(userDauserta);

          lat = double.parse(userDauserta["latitude"]);
          lon = double.parse(userDauserta["longitude"]);
          _center =  LatLng(lat, lon);
          title = userDauserta["service_status"] == "active"?"Online": "Offline";
          value_switch = (title == "Online")? true: false;



        });
        await prefs.setString("userjson", user!);
      }else{
        print(responce.statusCode);
      }
    });




  }
  Future<void> getAllServices() async {
    Uri url = Uri.parse(url_help.getAllServices);
    Map<String, String> header = {'Content-Type': 'application/json; charset=UTF-8'};

    await requestHelp.requestGet(url,header).then((responce) async {
      if (responce.statusCode == 200) {
        _services =  json.decode(responce.body);
        print(_services);

      }

    });

  }
  // Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //   // If you're going to use other Firebase services in the background, such as Firestore,
  //   // make sure you call `initializeApp` before using other Firebase services.
  //   await Firebase.initializeApp();
  //   NotificationBody = '${message.notification?.title}';
  //   MassageData = '${message.notification?.body}';
  //   globals.text = 1;
  //   setState(() {
  //     _height = 100;
  //   });
  // }
  double _height = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileData();
    getAllServices().then((value){
      setState(() {});
    });
    getCurrentLocation().then((value){
      x = _locationData.latitude!;
      y = _locationData.longitude!;
      print("x: $x y: $y");
      setState(() {
        _center = LatLng(x, y);
      });
    });

  }

  double _Containerheight = 0;
  double _ProvidersContainerheight = 0;
  String MassageData = "";
  String NotificationBody = "";
  @override
  Widget build(BuildContext context) {
    Color blue800 = Colors.blue.shade800;

//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//
//
//       if (message.notification != null) {
//         NotificationBody = '${message.notification?.title}';
//         MassageData = '${message.notification?.body}';
//         globals.text = 1;
//         setState(() {
//           _height = 100;
//         });
//         Future.delayed(const Duration(seconds: 5), () {
//
// // Here you can write your code
//
//           setState(() {
//             // Here you can write your code for open new view
//             _height = 0;
//           });
//
//         });
//       }
//     });
//     Locations.isEmpty?null:print("Id : ${Locations[0]["id"]}");
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    return Scaffold(
      key: _scaffoldKey,
      drawer: myDrawer(index: 0,),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            // _center.latitude == 0? Container():
            // Container(
            //   height: MediaQuery.of(context).size.height,
            //   child: GoogleMap(
            //     onMapCreated: _onMapCreated,
            //     initialCameraPosition: CameraPosition(
            //       target: _center,
            //       zoom: 15.0,
            //     ),
            //     myLocationEnabled: true,
            //     myLocationButtonEnabled: true,
            //     padding: EdgeInsets.only(top: 15.0.h ,bottom: MediaQuery.of(context).size.height / 8),
            //     onTap: (click){
            //       print(click);
            //     },
            //     trafficEnabled: true,
            //
            //   ),
            //
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                
                Container(
                        margin: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white
                        ),
                        child: Row(
                          children: [ 
                            Expanded(child: ElevatedButton(onPressed: (){
                              setState(() {
                                _Containerheight = 200;
                              });
                            }, child: Text("Wash Now"))),
                            Expanded(child: ElevatedButton(onPressed: (){}, child: Text("Schedule Wash"))),

                          ],
                        ),
                      ),
                  
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                duration: new Duration(milliseconds: 1000),
                curve: Curves.fastOutSlowIn,
                height: _Containerheight,
                width: double.infinity,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                  color: Colors.white
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: (){},
                          child: Text("Done"),
                        )
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _services.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index){
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  _Containerheight =0;
                                  _ProvidersContainerheight = 500;
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _services[index]["image"] == null?
                                  Icon(Icons.account_circle_rounded,size: 40,)
                                  : CircleAvatar(
                                    backgroundImage: NetworkImage("${url_help.getPhoto}${_services[index]["image"]}"),
                                  ),
                                  Text("${_services[index]["name"]}")
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                duration: new Duration(milliseconds: 2000),
                curve: Curves.fastOutSlowIn,
                height: _ProvidersContainerheight,
                width: double.infinity,

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                    color: Colors.white
                ),
                padding: EdgeInsets.all(12),
                child:ListView.builder(
                        itemCount: _services.length,
                        itemBuilder: (BuildContext context, int index){
                          return GestureDetector(
                              onTap: (){
                                setState(() {
                                  _ProvidersContainerheight = 0;
                                });
                              },
                              child: Card(
                                elevation: 10,
                                color: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(25))
                                ),
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  child: Row(

                                    children: [
                                      Icon(Icons.account_circle_rounded,size: 50,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("mohammed"),
                                          Text("Price : 25 AED", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),)
                                        ],
                                      ),
                                      Expanded(child: Rating(value: 3.5,))

                                    ],
                                  ),
                                ),
                              )
                            );

                        },
                      ),

              ),
            )
            // AnimatedContainer(
            //   height: _height,
            //   width: double.infinity,
            //   margin: EdgeInsets.symmetric(vertical: 4.5.h),
            //   duration: new Duration(milliseconds: 1000),
            //   curve: Curves.fastOutSlowIn,
            //   child:  GestureDetector(
            //     onTap: (){
            //       setState(() {
            //         _height = 0;
            //       });
            //     },
            //     child: Card(
            //
            //       elevation: 10,
            //
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //       color: Colors.greenAccent,
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child :Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text(NotificationBody, style: TextStyle(
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 15,
            //                 color: Colors.black
            //             ),),
            //             Text(MassageData, style: TextStyle(
            //                 fontSize: 12,
            //                 color: Colors.black
            //             ),)
            //           ],
            //         ),
            //         // child: Row(
            //         //   mainAxisSize: MainAxisSize.min,
            //         //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         //   children: [
            //         //     Column(
            //         //       mainAxisSize: MainAxisSize.min,
            //         //
            //         //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         //       children: [
            //         //         Row(
            //         //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         //           children: [
            //         //             Text("Booking Id: ${list[index]["booking_id"]}", style: TextStyle(
            //         //               fontWeight: FontWeight.bold,
            //         //               fontSize: 15,
            //         //             ),),
            //         //           ],
            //         //         ),
            //         //         Row(
            //         //           children: [
            //         //             Icon(Icons.account_circle_rounded, size: MediaQuery.of(context).size.height / 18,),
            //         //             Column(
            //         //               crossAxisAlignment: CrossAxisAlignment.start,
            //         //               children: [
            //         //                 Text(list[index]["user_name"]),
            //         //                 Text("Service: ${list[index]["service_name"]}", style: TextStyle(
            //         //                     fontWeight: FontWeight.bold,
            //         //                     fontSize: 15
            //         //                 ),)
            //         //               ],
            //         //             )
            //         //           ],
            //         //         ),
            //         //
            //         //       ],
            //         //     ),
            //         //     Column(
            //         //       mainAxisSize: MainAxisSize.min,
            //         //       children: [
            //         //         Column(
            //         //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         //           children: [
            //         //             ElevatedButton(onPressed: () async {
            //         //               Uri uri = Uri.parse(url_help.acceptRequest);
            //         //               Map<String,dynamic> body = {
            //         //                 "request_id" : list[index]['id'],
            //         //               };
            //         //               await requestHelp.requestPost(uri, body);
            //         //             }, child: Text("Accept"),style: ElevatedButton.styleFrom(
            //         //               primary: Colors.green,
            //         //             ),),
            //         //             ElevatedButton(onPressed: () async {
            //         //               Uri uri = Uri.parse(url_help.cancelRequest);
            //         //               Map<String,dynamic> body = {
            //         //                 "request_id" : list[index]['id'],
            //         //               };
            //         //               await requestHelp.requestPost(uri, body);
            //         //             }, child: Text("Cancel"),style: ElevatedButton.styleFrom(
            //         //               primary: Colors.red,
            //         //             ),),
            //         //
            //         //           ],
            //         //         ),
            //         //
            //         //       ],
            //         //     ),
            //         //
            //         //   ],
            //         // ),
            //       ),
            //
            //
            //     ),
            //   ),
            // )
          ],

        ),




      ),
    );
  }




}


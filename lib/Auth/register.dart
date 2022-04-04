import 'dart:convert';
import 'dart:io' show Platform;
// import 'package:car_washer/service.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:device_info/device_info.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../Helper/url_helper.dart' as url_helper;

import '../Helper/request_helper.dart';
// import 'otpVerfication.dart';


class register extends StatefulWidget{
  static String id = 'register_screen';

  @override
  _registerstate createState() => _registerstate();

}


class _registerstate extends State<register> {
  List<bool> values = [];
  request_helper requestHelp = new request_helper();
  String dialCodesDigits = "+971";


  url_helper.Constants url_help = new url_helper.Constants();

  static Future<void> getDeviceDetails() async {
    final prefs = await SharedPreferences.getInstance();
    String deviceName="";
    String deviceType="";
    String identifier="";
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceType = build.version.toString();
        identifier = build.androidId;  //UUID for Android
        await prefs.setString('deviceType', "android");
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceType = data.systemVersion;
        identifier = data.identifierForVendor;  //UUID for iOS
        await prefs.setString('deviceType', "ios");
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
    await prefs.setString('deviceName', deviceName);
    await prefs.setString('identifier', identifier);
    //if (!mounted) return;
  }



  void showLoading() async{
    await EasyLoading.show(
        status: 'loading...',
        maskType: EasyLoadingMaskType.black);
  }
  void hideLoading() async{
    await EasyLoading.dismiss();

  }

  void showError(String msg){
    EasyLoading.showError(msg);
  }

    TextEditingController _emailController = TextEditingController();
    TextEditingController _nameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _passwordconfirmController = TextEditingController();
    TextEditingController _phoneController = TextEditingController();


  Future<void> isMobileTaken (String phoneController) async{
    Uri uri = Uri.parse(url_help.isMobileTaken);

    Map <String, dynamic> body = {
      "mobile": "${phoneController.trim()}"
    };

    await requestHelp.requestPost(uri, body).then((response){
      if(json.decode(response.body)["msg"] == "Available"){
        isAvailable =true;
      }else{
        isAvailable =false;
      }

    });
  }

  Widget userInput(TextEditingController userInput, String hintTitle, TextInputType keyboardType, IconData icon, bool secure) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(color: Color(0xffEAEEF6), borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: TextField(
          controller: userInput,
          obscureText: secure,
          decoration: InputDecoration(
            hintText: hintTitle,
            hintStyle: TextStyle(fontSize: 18, color: Color(0xffB1B2BB), fontStyle: FontStyle.italic),
            contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
            border: InputBorder.none,
            prefixIcon: Icon(icon,color: Colors.indigo.shade800,),

          ),
          keyboardType: keyboardType,
        ),
      ),
    );

  }
  Widget phoneInput(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(color: Color(0xffEAEEF6), borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            CountryCodePicker(
              onChanged: (country){
                setState(() {
                  dialCodesDigits = country.dialCode!;
                });
              },
              initialSelection: "AE",
              showCountryOnly: false,
              showOnlyCountryWhenClosed: false,
              favorite: ["+971","+1","US"],
            ),
            Expanded(
              child: TextField(
                controller: userInput,
                decoration: InputDecoration(
                  hintText: hintTitle,
                  hintStyle: TextStyle(fontSize: 18, color: Color(0xffB1B2BB), fontStyle: FontStyle.italic),
                  contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                  border: InputBorder.none,

                ),
                keyboardType: keyboardType,
              ),
            ),
          ],
        ),
      ),
    );

  }

  bool isAvailable = false;
  @override
  Widget build(BuildContext context) {
    // readJson();
    void click() {
      Navigator.pushNamed(context, 'login');
    }

    // void register() async{
    //
    //   showLoading();
    //   String s = _phoneController.text[0] =="0"?_phoneController.text.substring(1):_phoneController.text;
    //   print(s);
    //   await isMobileTaken(s);
    //   if (_emailController.text.isEmpty || _passwordController.text.isEmpty || _nameController.text.isEmpty){
    //     hideLoading();
    //     showError('Please put some Data');
    //
    //
    //   }else if (_passwordController.text.length < 6){
    //     hideLoading();
    //     showError('Password must be at least 6 characters');
    //   }
    //   else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_emailController.text)){
    //     showError('Email address is badly formatted');
    //
    //   }else if (_passwordController.text != _passwordconfirmController.text){
    //     hideLoading();
    //     showError('Passwords doesn\'t match');
    //
    //   }else if(!isAvailable){
    //     hideLoading();
    //     showError("The mobile has already been taken.");
    //   }
    //   else if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty && _nameController.text.isNotEmpty && _phoneController.text.isNotEmpty) {
    //
    //
    //
    //
    //      FirebaseMessaging.instance.getToken().then((Dtoken) async {
    //       final prefs = await SharedPreferences.getInstance();
    //
    //       await getDeviceDetails();
    //
    //
    //       Map<String, dynamic> body = {
    //         "device_type": await prefs.getString('deviceType'),
    //         "device_id": await prefs.getString("identifier"),
    //         "device_token": Dtoken,
    //         "login_by": "manual",
    //         "first_name": _nameController.text,
    //         "email": _emailController.text.trim(),
    //         "password": _passwordController.text,
    //         "dialCodesDigits":dialCodesDigits,
    //         "mobile": "${s}"
    //       };
    //       hideLoading();
    //       Navigator.push(context, MaterialPageRoute(builder: (context) => otpVerfication(body: body,)));
    //
    //     });
    //   }
    //   }



    return Scaffold(
        body:
              SingleChildScrollView(
                child: Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,


                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,


                                children: [

                                  SizedBox(height: 15.0.h,),
                                  userInput(_nameController, "User Name", TextInputType.name, Icons.account_circle_rounded, false),


                                  SizedBox(height: 1.2.h,),

                                  userInput(_emailController, "Email", TextInputType.emailAddress, Icons.email, false),

                                  SizedBox(height: 1.2.h,),

                                  userInput(_passwordController, "Password", TextInputType.visiblePassword, Icons.lock, true),
                                  SizedBox(height: 1.2.h,),
                                  userInput(_passwordconfirmController, "Password Confirmation", TextInputType.visiblePassword, Icons.lock, true),
                                  SizedBox(height: 1.2.h,),

                                  phoneInput(_phoneController, "Phone Number", TextInputType.number),


                                  SizedBox(height: 2.0.h,),

                                  // getTableWidgets(_services),

                                  SizedBox(height: 1.2.h),
                                  Row(
                                    children: [
                                      Expanded(child: Container(

                                        child: ElevatedButton (

                                          onPressed: (){},
                                          child: Text("Register",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white,)),
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.indigo.shade800,
                                            padding: EdgeInsets.all(15),
                                            shape: RoundedRectangleBorder(
                                              
                                              borderRadius: BorderRadius.circular(25)
                                            )
                                        ),

                                        ),
                                        alignment: Alignment.center,
                                      )),
                                    ],
                                  ),


                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("You Already have an account?",
                                        style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),),
                                      TextButton(
                                        onPressed: click,
                                        child: const Text("Login",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      )
                                    ],
                                  ),

                                ],
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
              ),

              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: AnimatedContainer(
              //     duration: new Duration(milliseconds: 1000),
              //     curve: Curves.fastOutSlowIn,
              //     height: _height,
              //     width: double.infinity,
              //     child: Card(
              //       elevation: 20,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25)),
              //       ),
              //
              //       child: ListView.builder(
              //         itemCount: _services.length,
              //         itemBuilder: (BuildContext context, int index){
              //           return Container(
              //             margin: EdgeInsets.symmetric(horizontal: 10),
              //             child: Column(
              //               children: [
              //                 index == 0?
              //                 Row(
              //                   children: [
              //                     Expanded(
              //                       child: Align(
              //                         alignment: Alignment.centerRight,
              //                         child: TextButton(
              //                           child: Text("Done"),
              //                           onPressed: (){
              //                             for(int i = 0; i < servicesControllers.length; i++) {
              //                               if (servicesControllers[i]
              //                                   .getController()
              //                                   .text
              //                                   .isEmpty && values[i] == true) {
              //
              //                                 break;
              //                               }else if(values[i] == false){
              //                                 setState(() {
              //                                   servicesControllers[i]
              //                                       .getController()
              //                                       .text = "";
              //                                 });
              //                               } else {
              //
              //                                 setState(() {
              //                                   _height = 0;
              //                                 });
              //                               }
              //
              //                             }
              //
              //                           },
              //                         ),
              //                       ),
              //                     )
              //                   ],
              //                 ): Container(),
              //                 index == 0?
              //                     Row(
              //                       children: [
              //                         Expanded(child: Text("Available"),flex: 1,),
              //                         Expanded(child: Container(child: Text("ٍService Name")
              //                         , margin: EdgeInsets.only(left: 8, top: 5),
              //                         ),flex: 2,),
              //                         Expanded(child: Text("Service Price (AED)"),flex: 3,)
              //                       ],
              //                     ): Container(),
              //                 Row(
              //                   children: [
              //                     Expanded(child: Checkbox(value: values[index], onChanged: (value){
              //                       setState(() {
              //                         values[index] = value!;
              //                       });
              //                     }),flex: 1,),
              //                     Expanded(child: Container(child: Text(_services[index]["name"]), margin: EdgeInsets.only(left: 8),),flex: 2,),
              //                     Expanded(child: TextField(
              //                       decoration: InputDecoration(
              //                         hintText: "Price (AED)",
              //                         errorText: values[index] ? 'Value Can\'t Be Empty' : null,
              //                       ),
              //                       enabled: values[index],
              //
              //                       controller: servicesControllers[index].getController(),
              //
              //                     ),flex: 3,)
              //                   ],
              //                 ),
              //               ],
              //             ),
              //           );
              //         },
              //       ),
              //     ),
              //   ),
              // )


    );
  }


}
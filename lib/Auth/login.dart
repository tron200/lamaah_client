import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;

import '../Helper/request_helper.dart';
import 'package:device_info/device_info.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../Helper/url_helper.dart' as url_helper;
// import '../icons.dart';


class login extends StatefulWidget{
  static String id = 'login_screen';

  @override
  _loginstate createState() => _loginstate();

}



class _loginstate extends State<login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  request_helper request_help = new request_helper();
  url_helper.Constants constants = new url_helper.Constants();
  void forgetpassword() {
    ////////////////////////////////////////////////////////////////////////////////////////////////////

  }
  static Future<bool> getDeviceDetails() async {
    final prefs = await SharedPreferences.getInstance();
    String deviceName="";
    String identifier="";
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        identifier = build.androidId;  //UUID for Android
        await prefs.setString('deviceType', "android");
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        identifier = data.identifierForVendor;  //UUID for iOS
        await prefs.setString('deviceType', "ios");
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
    await prefs.setString('deviceName', deviceName);
    await prefs.setString('identifier', identifier);
    //if (!mounted) return;
    return true;
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

  void showSucess(){
    EasyLoading.showSuccess("Everything looks Good");
  }


  // Widget signInWith(IconData icon,void click()) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1),
  //       borderRadius: BorderRadius.circular(25),
  //
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Icon(icon, size: 24, color: icon == Icons.facebook? Colors.blue: Colors.red,),
  //         TextButton(onPressed: click, child: Text('Sign in', style: TextStyle(
  //           color: Colors.black
  //         ),),),
  //       ],
  //     ),
  //   );
  // }

  Widget userInput(TextEditingController userInput, String hintTitle, TextInputType keyboardType) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(color: Color(0xffEAEEF6), borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: TextField(
          controller: userInput,
          obscureText: hintTitle == "Email"?false: true,
          decoration: InputDecoration(
            hintText: hintTitle,
            hintStyle: TextStyle(fontSize: 18, color: Color(0xffB1B2BB), fontStyle: FontStyle.italic),
            contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
            border: InputBorder.none,
            prefixIcon: hintTitle == "Email"?Icon(Icons.email,color: Colors.indigo.shade800,): Icon(Icons.lock, color: Colors.indigo.shade800,),

          ),
          keyboardType: keyboardType,
        ),
      ),
    );

  }

  double _height = 0;




  @override
  Widget build(BuildContext context) {
    void click() {
      Navigator.pushNamed(context, 'register');

    }

    Future.delayed(const Duration(milliseconds: 500), () {

// Here you can write your code

      setState(() {
        // Here you can write your code for open new view
        _height = 600;
      });

    });

    // Future<UserCredential> signInWithFacebook() async {
    //   final prefs = await SharedPreferences.getInstance();
    //   // Trigger the sign-in flow
    //   final LoginResult loginResult = await FacebookAuth.instance.login();
    //
    //   // Create a credential from the access token
    //   final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
    //   await prefs.setString("access_token", loginResult.accessToken!.token);
    //   // Once signed in, return the UserCredential
    //   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    // }

    // Future<void> facebookLogin() async {
    //   WidgetsFlutterBinding.ensureInitialized();
    //   final prefs = await SharedPreferences.getInstance();
    //   FirebaseMessaging.instance.getToken().then((Dtoken){
    //     signInWithFacebook().then((facebookAuthCredential) async {
    //       await prefs.setString("device_token", Dtoken!);
    //       await getDeviceDetails();
    //       //FACEBOOK_signin
    //
    //       Uri uri = Uri.parse(constants.FACEBOOK_LOGIN);
    //       Map<String, dynamic> body = {
    //         "device_type": await  prefs.getString("deviceType"),
    //         "device_token": Dtoken,
    //         "access_token": await prefs.getString("accessToken"),
    //         "device_id": await prefs.getString("identifier"),
    //         "login_by": "google"
    //       };
    //
    //       request_help.requestPost(uri, body).then((response){
    //         if(response.statusCode == 200){
    //           print(response.statusCode);
    //           print(response.body);
    //         }else{
    //           print(response.statusCode);
    //           print(response.body);
    //         }
    //       });
    //
    //     });
    //   });
    // }

    // Future<User?> signInWithGoogle({required BuildContext context}) async {
    //   FirebaseAuth auth = FirebaseAuth.instance;
    //   User? user;
    //
    //   if (kIsWeb) {
    //     GoogleAuthProvider authProvider = GoogleAuthProvider();
    //
    //     try {
    //       final UserCredential userCredential =
    //       await auth.signInWithPopup(authProvider);
    //
    //       user = userCredential.user;
    //     } catch (e) {
    //       print(e);
    //     }
    //   } else {
    //     final GoogleSignIn googleSignIn = GoogleSignIn();
    //
    //     final GoogleSignInAccount? googleSignInAccount =
    //     await googleSignIn.signIn();
    //
    //     if (googleSignInAccount != null) {
    //
    //       await googleSignInAccount.authentication.then((googleSignInAuthentication) async {
    //         final prefs = await SharedPreferences.getInstance();
    //         await prefs.setString("access_token", googleSignInAuthentication.accessToken!);
    //         final AuthCredential credential = GoogleAuthProvider.credential(
    //           accessToken: googleSignInAuthentication.accessToken,
    //           idToken: googleSignInAuthentication.idToken,
    //         );
    //         try {
    //           final UserCredential userCredential =
    //           await auth.signInWithCredential(credential);
    //
    //           user = userCredential.user;
    //         } on FirebaseAuthException catch (e) {
    //           if (e.code == 'account-exists-with-different-credential') {
    //             // ...
    //           } else if (e.code == 'invalid-credential') {
    //             // ...
    //           }
    //         } catch (e) {
    //           // ...
    //         }
    //       });
    //
    //     }
    //   }
    //
    //   return user;
    // }

    // Future<void> googleLogin() async {
    //     final prefs = await SharedPreferences.getInstance();
    //     WidgetsFlutterBinding.ensureInitialized();
    //     FirebaseMessaging.instance.getToken().then((Dtoken){
    //     signInWithGoogle(context: context).then((user) async {
    //
    //         print("gtoken ${await prefs.getString("access_token")}");
    //         await getDeviceDetails();
    //         //GOOGLE_LOGIN
    //         Uri uri = Uri.parse(constants.GOOGLE_LOGIN);
    //         Map<String, dynamic> body = {
    //           "device_type": await  prefs.getString("deviceType"),
    //           "device_token": Dtoken,
    //           "access_token": await prefs.getString("access_token"),
    //           "device_id": await prefs.getString("identifier"),
    //           "login_by": "google"
    //           };
    //         print(body);
    //         request_help.requestPost(uri, body).then((response) async {
    //           if(response.statusCode == 200){
    //             print(json.decode(response.body)["access_token"]);
    //             await prefs.setString("access_token", "${json.decode(response.body)["access_token"]}").then((value){
    //             Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
    //             });
    //           }else{
    //             print(response.statusCode);
    //             print(response.body);
    //           }
    //         });
    //
    //       });
    //     });
    // }
    Future<void> signin() async {
      //here _emailController.text
      showLoading();
      if (_emailController.text.isEmpty || _passwordController.text.isEmpty){
        hideLoading();
        showError('Please put some Data');


      }else if (_passwordController.text.length < 6){
        hideLoading();
        showError('Password must be at least 6 characters');
      }
      else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_emailController.text)){
        showError('Email address is badly formatted');
      } else if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
        WidgetsFlutterBinding.ensureInitialized();

        final prefs = await SharedPreferences.getInstance();
        // check error waiting
        // FirebaseMessaging.instance.getToken().then((token) async {
        //   await getDeviceDetails();
        //
        //   await prefs.setString('device_token', token!);
        //
        //   Uri uri = Uri.parse(constants.login);
        //   Map<String, dynamic> body = {
        //     "grant_type": "password",
        //     "client_id": constants.client_id,
        //     "client_secret": constants.client_secret,
        //     "email": _emailController.text.toString().trim(),
        //     "scope": "",
        //     "logged_in": "1",
        //     "password": _passwordController.text,
        //     "device_type": await prefs.getString("deviceType"),
        //     "device_id": await prefs.getString("identifier"),
        //     "device_token": await prefs.getString("device_token")
        //   };
        //   request_help.requestPost(uri, body).then((response) async {
        //     if (response.statusCode == 200) {
        //       hideLoading();
        //       showSucess();
        //       print("Done");
        //       await prefs.setString("access_token",
        //           "${json.decode(response.body)["access_token"]}").then((
        //           value) {
        //         Navigator.pushNamedAndRemoveUntil(
        //             context, 'home', (route) => false);
        //       });
        //     } else if (response.statusCode == 401) {
        //       //show error email or pasword in correct
        //       hideLoading();
        //       showError("Email or Password is incorrect");
        //       print(response.statusCode);
        //     } else {
        //       //show error : else if internet connection lost or something error
        //       showError("Internet Connection lost or Something Went Wrong");
        //       print(response.body);
        //       print(response.body);
        //     }
        //   });
        // });
      }
    }



    return Scaffold(
      resizeToAvoidBottomInset :false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            fit: BoxFit.fill,
            image: NetworkImage(
              'https://www.teahub.io/photos/full/246-2460189_full-hd-background-abstract-portrait.jpg',
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedContainer(
                  duration: Duration(seconds: 2),
                  curve: Curves.fastOutSlowIn,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: _height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 45),
                              userInput(_emailController, 'Email', TextInputType.emailAddress),
                              userInput(_passwordController, 'Password', TextInputType.visiblePassword),
                              Container(
                                height: 55,
                                // for an exact replicate, remove the padding.
                                // pour une réplique exact, enlever le padding.
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                    primary: Colors.indigo.shade800,
                                  ),
                                  onPressed: signin,
                                  child: Text('Sign in', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white,),),
                                ),
                              ),
                              SizedBox(height: 20),
                              Center(child: TextButton(child: Text('Forgot password ?'), onPressed: forgetpassword,),),
                              SizedBox(height: 20),
                              // Padding(
                              //   padding: const EdgeInsets.only(top: 25.0),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //     children: [
                              //      signInWith(Icons.facebook,facebookLogin),
                              //      signInWith(MyFlutterApp.google_plus_circle, googleLogin),
                              //     ],
                              //   ),
                              // ),
                              SizedBox(height: 0.9.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Don\'t have an account yet ? ', style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),),
                                  TextButton(
                                    onPressed: click,
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                    ),
                                  ),

                                ],
                              ),

                            ],
                          ),
                        )
                        )
                      ],
                    ),
                  ),
                ),


          ],
        ),
      ),
    );

  }


}

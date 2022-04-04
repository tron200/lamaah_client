import 'dart:collection';
import 'dart:convert';

import '../Helper/request_helper.dart';
// import 'package:car_washer/myDrawer.dart';
import 'package:country_code_picker/country_code_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../Helper/url_helper.dart' as url_helper;
// import '../screens/servicesScreen.dart';


class otpVerfication extends StatefulWidget{
  Map<String, dynamic> body;
  otpVerfication({required this.body});
  @override
  _otpVerficationState createState() => _otpVerficationState();
}

class _otpVerficationState extends State<otpVerfication>{
  int _index = 0;
  static Map<String, dynamic> body = new HashMap();
  static String smsCode = "";
  void submitOtp(){
    ///////////////////////////
  }
  // final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _otpFoucsNode = FocusNode();
  String? VerficationCode;
  final BoxDecoration pinOtpCodeVerfication = BoxDecoration(
      color: Colors.blueAccent,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
          color: Colors.grey
      )
  );



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    body = widget.body;
  }
  static String verificationId1 = "";
  static bool recived = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    WidgetsFlutterBinding.ensureInitialized();
    String dialCodesDigits = body['dialCodesDigits'];
    String phone = body['mobile'];
    // sendverifyphone(dialCodesDigits, phone, smsCode);
    print("hi $dialCodesDigits  $phone");
    return Scaffold(
        appBar: AppBar(
          title: Text("Otp Verfication"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ),
        body:
        Container(

          padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 8.0.w),
          child:
          PinPut(
            fieldsCount: 6,
            textStyle: TextStyle(fontSize: 25.0, color: Colors.white),
            eachFieldWidth: 40.0,
            eachFieldHeight: 55.0,
            controller: _otpController,
            focusNode: _otpFoucsNode,
            selectedFieldDecoration: pinOtpCodeVerfication,
            submittedFieldDecoration: pinOtpCodeVerfication,
            followingFieldDecoration: pinOtpCodeVerfication,
            pinAnimationType: PinAnimationType.rotation,
            onSubmit: (pin) async{
              try{
                // verifyPhone();

                // String dialCodesDigits = body['dialCodesDigits'];
                // String phone = body['mobile'];
                // print("hi $dialCodesDigits  $phone");
              }catch(e){

              }
            },
          ),


        )
    );


  }
  // sendverifyphone(String dialCodesDigits, String phone,String smsCode) async {
  //
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   await auth.verifyPhoneNumber(
  //     phoneNumber: "${dialCodesDigits}${phone}",
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       // ANDROID ONLY!
  //       print("hi $credential");
  //       // Sign the user in (or link) with the auto-generated credential
  //       await auth.signInWithCredential(credential);
  //     }, verificationFailed: (FirebaseAuthException error) {
  //     hideLoading();
  //   },
  //     codeAutoRetrievalTimeout: (String verificationId){
  //       hideLoading();
  //     },
  //     codeSent: (String verificationId, int? forceResendingToken) async {
  //       // Create a PhoneAuthCredential with the code
  //       verificationId1 = verificationId;
  //       recived = true;
  //
  //       // Sign the user in (or link) with the credential
  //     },
  //   );
  // }
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
  // verifyPhone() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: verificationId1, smsCode: _otpController.text);
  //   showLoading();
  //   await auth.signInWithCredential(credential).then((value){
  //     if(value.user != null){
  //       url_helper.Constants url_help = new url_helper.Constants();
  //       request_helper request_help = new request_helper();
  //       Uri uri = Uri.parse(url_help.register);
  //       request_help.requestPost(uri, body).then((response) async{
  //         if (response.statusCode == 200) {
  //           print(json.decode(response.body));
  //           // if(json.decode(response.body)["error"] == true){
  //           //   hideLoading();
  //           //   showError("The email has already been taken.");
  //           //
  //           // }else {
  //             hideLoading();
  //             //login?
  //             await prefs.setString("access_token", json.decode(response.body)[0]["access_token"]);
  //             // print(json.decode(response.body)["id"].runtimeType);
  //             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ServicesScreen(id: "${json.decode(response.body)[0]["id"]}",)),  (route) => false);
  //           // }
  //         }
  //         else {
  //           hideLoading();
  //           showError("registration error");
  //
  //         }
  //       });
  //     }
  //   });
  // }
}
import 'package:flutter/material.dart';
import 'package:lammah_client/homeScreen.dart';
import 'package:sizer/sizer.dart';

import 'Auth/login.dart';
import 'Auth/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Sizer(builder: (context, orientation, deviceType){
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
        routes: {
          'login' : (context) => login(),
          'register': (context) => register(),
        },

      );
    });
  }
}


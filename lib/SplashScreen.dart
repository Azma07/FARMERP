import 'dart:async';
import 'package:farm/farmerList.dart';
import 'package:flutter/material.dart';
import 'farmerList.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);


  _SplashScreenState createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
            ()=>Navigator.pushReplacement(this.context, MaterialPageRoute(builder: (context)=>FarmerList())

        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,




    );
  }
}

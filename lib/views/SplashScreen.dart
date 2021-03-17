import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _SplashScreenState();

  final String nextRoute;

  SplashScreen({this.nextRoute});
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
            () {
          Navigator.of(context).pushReplacementNamed(widget.nextRoute);
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text("Trajectory Shop", style: TextStyle(fontSize: 40, color: Colors.white),),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import 'package:trajectory_shop/views/CategoriesList.dart';
import 'package:trajectory_shop/views/ProductsList.dart';
import 'package:trajectory_shop/views/SplashScreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final routes = <String, WidgetBuilder>{
    '/categories': (BuildContext context) => CategoriesList(title: 'Trajectory Shop'),
    '/offers': (BuildContext context) => ProductsList(title: "Trajectory Shop",)
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trajectory Shop',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
      home: SplashScreen(nextRoute: "/categories",),
      routes: routes,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/screens/home_screen.dart';

void main(){
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green
      ),
      home: HomeScreen(),
    );
  }
}

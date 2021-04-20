import 'package:flutter/material.dart';
import 'package:grocery_app/Universals/floatingActionButton.dart';
import 'package:grocery_app/screens/home_screen.dart';

class AdminScreen extends StatefulWidget {

  static const String id = 'admin-screen' ;

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              'Admin Panel'
            )
          ],
        ),
      ),
      floatingActionButton: FloatingButton()
    );
  }
}

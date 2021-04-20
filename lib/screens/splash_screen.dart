import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/screens/home_screen.dart';
import 'package:grocery_app/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash-screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    Timer(
        Duration(
          seconds: 3,
        ), (){
      FirebaseAuth.instance.authStateChanges().listen((User user) {
        if(user==null){
          Navigator.pushReplacementNamed(context, WelcomeScreen.id);
        }else{
          Navigator.pushReplacementNamed(context, HomeScreen.id);
        }
      });
    }
    );

    super.initState();
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
            tag: 'logo',
            child: Image.asset('Images/logo.jpg')),
      ),
    );
  }
}
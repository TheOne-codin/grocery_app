import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Firebasedata/firebase_data.dart';
import 'package:grocery_app/screens/admin/admin_screen/admin_screen.dart';
import 'package:grocery_app/screens/home_screen.dart';
import 'package:grocery_app/screens/vendor/vendor_screen.dart';

class VerificationScreen extends StatefulWidget {

  static const String id = 'verification-screen';

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {

  final auth = FirebaseAuth.instance;
  FirebaseFirestore userData = FirebaseFirestore.instance;

  User user;
  Timer timer;

  @override
  void initState() {
    user = auth.currentUser;
    user.sendEmailVerification();
    
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Please check your email to verify"),
      ),
    );
  }

  Future<void>checkEmailVerified() async {
    user = auth.currentUser;
    await user.reload();
    if(user.emailVerified) {
      timer.cancel();
      getUserData();
    if(admin!=true){
    if(vendor!=true){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));

    } else if(vendor==true){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> VendorScreen()));
    }
    }else{
    Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminScreen()));
    }
  }
  }

}

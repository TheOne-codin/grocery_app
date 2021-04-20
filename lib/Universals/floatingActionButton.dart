import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Firebasedata/firebase_data.dart';
import 'package:grocery_app/screens/admin/admin_screen/admin_screen.dart';
import 'package:grocery_app/screens/home_screen.dart';
import 'package:grocery_app/screens/menu_screen.dart';
import 'package:grocery_app/screens/welcome_screen.dart';

class FloatingButton extends StatefulWidget {
  @override
  _FloatingButtonState createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton> {

  String id = 'admin-screen';
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(50, 0, 20, 0),
        decoration: BoxDecoration(
            color: Colors.deepOrangeAccent,
            borderRadius: BorderRadius.circular(20),

        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              heroTag: 'home',
              backgroundColor: Colors.transparent,
              elevation: 0,
              onPressed: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomeScreen()));
              },
              child: Icon(Icons.home),
            ),
            FloatingActionButton(
              heroTag: 'cart',
              backgroundColor: Colors.transparent,
              elevation: 0,
              onPressed: (){

              },
              child: Icon(Icons.add_shopping_cart),
            ),
            FloatingActionButton(
              heroTag: 'profile',
              backgroundColor: Colors.transparent,
              elevation: 0,
              onPressed: (){

              },
              child: Icon(Icons.person),
            ),
            FloatingActionButton(
              heroTag: 'logout',
              backgroundColor: Colors.transparent,
              elevation: 0,
              onPressed: (){
              Navigator.pushNamed(context, MenuScreen.id);
              },
              child: Icon(Icons.menu),
            ),
          ],
        ),
    );
  }
}

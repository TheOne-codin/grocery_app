import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Firebasedata/firebase_data.dart';
import 'package:grocery_app/screens/Authentication/signUp.dart';
import 'package:grocery_app/screens/admin/admin_screen/admin_screen.dart';
import 'package:grocery_app/screens/home_screen.dart';
import 'package:grocery_app/screens/vendor/vendor_screen.dart';
import 'package:grocery_app/screens/welcome_screen.dart';

class SignIn extends StatefulWidget {
  static const String id = 'signIn-screen';
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _email; String _password; String _error='';

  final _auth = FirebaseAuth.instance;

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 35.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> WelcomeScreen() ));
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
                          backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent)
                        ),
                        child: Icon(Icons.arrow_back) ),
                    Text('Log In',
                      style: GoogleFonts.roboto(
                        textStyle:
                      TextStyle(
                        fontSize: 30,
                        color: Colors.deepOrangeAccent
                      ),
                      )
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Email'
                      ),
                      onChanged: (value){
                        setState(() {
                          _email = value.trim();
                        });
                      },
                    ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Password'
                      ),
                      onChanged: (value){
                        setState(() {
                          _password = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 25.0),
                child: Text(
                  _error,
                  style: TextStyle(
                    color: Colors.red
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextButton(
                onPressed: (){
                  _signIn();
                },
                child: Text('Sign In',
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text('- Or -'),
              SizedBox(
                height: 20,
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0))
                ),
                  onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUp()));
                  },
                  child: Text('Register',
                  style: TextStyle(
                    color: Colors.white
                  ),))
            ],
          ),
        ),
      ),
    );
  }


  _signIn() async {
    try{
      _auth.signInWithEmailAndPassword(email: _email, password: _password).then((value) =>{
        getUserData(),
        if(admin!=true){
          if(vendor!=true){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()))

          } else if(vendor==true){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> VendorScreen()))
        }
      }else{
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminScreen()))
        }
    }
    );
    } on FirebaseAuthException catch(e){
      setState(() {
        _error = e.message;
      });
    }

  }
}

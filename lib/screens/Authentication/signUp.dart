import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/Firebasedata/firebase_data.dart';
import 'package:grocery_app/screens/Authentication/signIn.dart';
import 'package:grocery_app/screens/Authentication/verification_screen.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
 String name=''; String phoneNumber=''; String _email=''; String _password='';  String uid='';
 bool admin = false; bool vendor = false;
 String _error='';

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
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> SignIn() ));
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<CircleBorder>(CircleBorder()),
                            backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent)
                        ),
                        child: Icon(Icons.arrow_back) ),
                    Text('Sign Up',
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
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        hintText: 'Your Name'
                    ),
                    onChanged: (value){
                      setState(() {
                        name = value.trim();
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Mobile Number'
                  ),
                  onChanged: (value){
                    setState(() {
                     phoneNumber = value.trim();
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
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
              ),
              CheckboxListTile(
                title: Text('Are you a Vendor?'),
                  value: vendor,
                  onChanged: (bool newValue){
                    setState(() {
                      vendor = newValue;
                    });
                  }),
              Text(
                  _error,
                style: TextStyle(
                  color: Colors.red
                ),
              ),


              TextButton(
                  onPressed: (){
                    _signUp();
                  },
                  child: Text('Register',
                  style: TextStyle(
                    color: Colors.white
                  ),
                  ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

 _signUp() async {
   try{
     await _auth.createUserWithEmailAndPassword(email: _email, password: _password).then((value) => {
         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> VerificationScreen())),
     createUser(name, phoneNumber, _email, admin, vendor)
     });

   } on FirebaseAuthException catch(e){
     setState(() {
       _error = e.message;
     });

   }
 }

}

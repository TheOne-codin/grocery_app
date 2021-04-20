
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/providers/auth_provider.dart';
import 'package:grocery_app/providers/location_provider.dart';
import 'package:grocery_app/screens/Authentication/signIn.dart';
import 'package:grocery_app/screens/map_screen.dart';
import 'package:grocery_app/screens/onboard_screen.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome-screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {



  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<AuthProvider>(context);

    bool _validPhoneNumber = false;
    var _phoneNumberController = TextEditingController();
    

    final locationData = Provider.of<LocationProvider>(context, listen: false);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Positioned(
              right: 0.0,
                top: 10.0,
                child: TextButton(
                  child: Text("Skip", style: TextStyle(
                    color: Colors.deepOrangeAccent,
                  ),),
                  onPressed: (){

                  },
                ), ),
            Column(
              children: [
                Expanded(child: OnBoardScreen()),
                Text('Ready To Order?'),
                SizedBox(height: 20,),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent)
                  ),
                    onPressed: () async {
                      await locationData.getCurrentPosition();
                    if(locationData.permissionAllowed==true){
                        Navigator.pushReplacementNamed(context, MapScreen.id);
                    }else{
                      print('Permission not Allowed');
                    }
                    },
                    child: Text(
                      "Set Delivery Location",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                ),
                SizedBox(height: 20,),
                TextButton(
                  child: RichText(text: TextSpan(
                  text: 'Already a Customer?',
                  style: TextStyle(
                    color: Colors.black
                  ),
                  children: [
                    TextSpan(
                      text: ' Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                  ],
                  ),
                  ),
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignIn()));
                    },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

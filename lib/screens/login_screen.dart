import 'package:flutter/material.dart';
import 'package:grocery_app/providers/auth_provider.dart';
import 'package:grocery_app/providers/location_provider.dart';
import 'package:grocery_app/screens/home_screen.dart';
import 'package:provider/provider.dart';


class LogInScreen extends StatefulWidget {

  static const String id = 'login-screen';

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {


  bool _validPhoneNumber = false;
  var _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<AuthProvider>(context);
    final locationData = Provider.of<LocationProvider>(context);


    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(55.0),
            child: Column(
              children: [
                Visibility(
                  visible: auth.error == 'Invalid OTP' ? true : false,
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          auth.error,
                          style: TextStyle(
                              color: Colors.red
                          ),),
                        SizedBox(height: 20.0,)
                      ],
                    ),
                  ),
                ),
                Text('LOGIN',style: TextStyle(fontSize: 25.0),),
                SizedBox(height: 5,),
                Text('Enter Your Phone Number To Login', style: TextStyle(fontSize: 12),),
                SizedBox(height: 20.0,),
                TextField(
                  decoration: InputDecoration(
                    prefixText: '+91',
                    labelText: 'Enter 10 digit mobile number',
                  ),
                  autofocus: true,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  controller: _phoneNumberController,
                  onChanged: (value){
                    if(value.length==10){
                      setState((){
                        _validPhoneNumber = true;
                      });
                    } else{
                      setState((){
                        _validPhoneNumber = false;
                      });
                    }
                  },

                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AbsorbPointer(
                      absorbing: _validPhoneNumber ? false : true,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: _validPhoneNumber ? MaterialStateProperty.all(Theme.of(context).primaryColor) : MaterialStateProperty.all(Colors.grey) ,
                        ),
                        onPressed: (){
                          String number = '+91${_phoneNumberController.text}';
                          auth.verifyPhone(
                            context: context,
                            number: number,
                            latitude: locationData.latitude,
                            longitude: locationData.longitude,
                            address: locationData.selectedAddress.addressLine

                          ).then((value){
                            _phoneNumberController.clear();
                            Navigator.pushReplacementNamed(context, HomeScreen.id);
                          });
                        },
                        child: Text(_validPhoneNumber ? 'Continue' :
                        'Enter Phone Number',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),

                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );

  }
}

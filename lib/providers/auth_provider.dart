import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/providers/location_provider.dart';
import 'package:grocery_app/screens/home_screen.dart';
import 'package:grocery_app/services/user_services.dart';

class AuthProvider with ChangeNotifier{

  FirebaseAuth _auth = FirebaseAuth.instance;

  String smsOtp;
  String verificationId;
  String error = '';
  UserServices _userServices = UserServices();
  LocationProvider locationData = LocationProvider();

  Future<void>verifyPhone({BuildContext context, String number, double latitude, double longitude, String address }) async {
    final PhoneVerificationCompleted verificationCompleted = (PhoneAuthCredential credential)async{
      await _auth.signInWithCredential(credential);
    };

    final PhoneVerificationFailed verificationFailed = (FirebaseAuthException e) {
      if (e.code == 'invalid-phone-number') {
        print('The provided phone number is not valid.');
        this.error=e.toString();
      }
    };

    final PhoneCodeSent codeSent = (String verId, int resendToken) async {
      this.verificationId = verId;

      //dialog to enter received OTP sms

      smsOtpDialog(context, number, latitude, longitude, address);

    };

    try{
      _auth.verifyPhoneNumber(
          phoneNumber: number,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: (String verId){
            this.verificationId = verId;

          },
      );
    }catch(e){
      this.error=e.toString();
      print(e);
    }
  }

  Future<bool>smsOtpDialog(BuildContext context, String number, double latitude, double longitude, String address){
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Column(
              children: [
                Text('Verification Code'),
                SizedBox(height: 20.0,),
                Text('Enter 6 digit OTP received as sms',
                  style: TextStyle(
                    color: Colors.grey, fontSize: 12
                ),
                ),
              ],
            ),
            content: Container(
              height: 85,
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 6,
                onChanged: (value){
                  this.smsOtp = value;
                },
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    try{
                     PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: verificationId, smsCode: smsOtp);

                     final User user = (await _auth.signInWithCredential(credential)).user;

                     if(locationData.selectedAddress!=null){
                       updateUser(id: user.uid, number: user.phoneNumber, latitude: locationData.latitude, longitude: locationData.longitude, address: locationData.selectedAddress.addressLine);
                     }else{
                     //create user data in fireStore after user successfully registered
                     _createUser(id: user.uid, number: user.phoneNumber, latitude: latitude, longitude: longitude, address: address);
                     }

                      //navigate to homepage after login

                      if(user!=null){
                        Navigator.of(context).pop();

                        //not to come back to welcome screen after logged in
                        Navigator.pushReplacementNamed(context,HomeScreen.id);
                      }else{
                        print('login failed');
                      }

                    }catch(e){

                      this.error = 'Invalid OTP';
                      print(e.toString());
                      Navigator.of(context).pop();

                    }
                  },
                  child: Text(
                    'DONE'
                  ))
            ],
          );
        });
  }

  void _createUser({String id, String number, double latitude, double longitude, String address}) {
    _userServices.createUserData({
      'id': id,
      'number': number,
      'location': GeoPoint(latitude, longitude),
      'address' : address

    });
  }


  void updateUser({String id, String number, double latitude, double longitude, String address}) {
    _userServices.updateUserData({
      'id': id,
      'number': number,
      'location': GeoPoint(latitude, longitude),
      'address' : address

    });
  }



}
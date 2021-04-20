import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grocery_app/providers/auth_provider.dart';
import 'package:grocery_app/providers/location_provider.dart';
import 'package:grocery_app/screens/Authentication/signIn.dart';
import 'package:grocery_app/screens/login_screen.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  static const String id = 'map-screen';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  LatLng currentLocation;
  GoogleMapController _mapController;
  bool _loggedIn = false;
  User user;
  
  @override
  void initState() {
    //check user logged in or not, while opening map screen
    getCurrentUser();

    super.initState();
  }
  
  void getCurrentUser(){
    User user = FirebaseAuth.instance.currentUser;
    if(user!=null){
      setState(() {
        _loggedIn=true;
        user=FirebaseAuth.instance.currentUser;
      });
    }
  }
  
  @override
  
  Widget build(BuildContext context) {
    final locationData = Provider.of<LocationProvider>(context);
    final _auth = Provider.of<AuthProvider>(context);

    setState(() {
      currentLocation = LatLng(locationData.longitude, locationData.longitude);
    });

    void onMapCreated(GoogleMapController controller){
      setState(() {
        _mapController=controller;
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: currentLocation,
                zoom: 14.4746,
              ),
              zoomControlsEnabled: false,
              minMaxZoomPreference: MinMaxZoomPreference(
                  1.5,
                  20.8),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              mapToolbarEnabled: true,
              onCameraMove: (CameraPosition position){
                locationData.onCameraMove(position);
              },
              onMapCreated: onMapCreated,
              onCameraIdle: (){
                locationData.getMoveCamera();
              },
            ),

            Positioned(
              bottom: 0.0,
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Flexible(
                    child: Column(
                      children: [
                        TextButton.icon(icon: Icon(Icons.location_searching), label:
                        Text(locationData.selectedAddress.featureName,
                          overflow: TextOverflow.ellipsis,),
                          onPressed: () {

                        },
                        ),
                        Text(locationData.selectedAddress.addressLine),
                        SizedBox(height: 30,),
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent),
                          ),
                            onPressed: (){
                            if(_loggedIn==false){
                              Navigator.pushNamed(context, SignIn.id);
                            }else{
                              _auth.updateUser(
                                id: user.uid,
                                number: user.phoneNumber,
                                latitude: locationData.latitude,
                                longitude: locationData.longitude,
                                address: locationData.selectedAddress.addressLine,
                              );
                            }
                            },
                            child: Text('CONFIRM LOCATION',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            ),
                        ),
                      ],
                    ),
                  ),
                ),
                
              ),
            ),
            Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 40),
                  height: 50.0,
                    child: Image.asset('Images/marker.png'),
                ),
            ),

          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:grocery_app/providers/auth_provider.dart';
import 'package:grocery_app/providers/location_provider.dart';
import 'package:grocery_app/screens/Authentication/signIn.dart';
import 'package:grocery_app/screens/Authentication/verification_screen.dart';
import 'package:grocery_app/screens/home_screen.dart';
import 'package:grocery_app/screens/map_screen.dart';
import 'package:grocery_app/screens/menu_screen.dart';
import 'package:grocery_app/screens/splash_screen.dart';
import 'package:grocery_app/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
        create: (_)=>AuthProvider(),
      ),
        ChangeNotifierProvider(
          create: (_)=>LocationProvider(),
        )
      ],
    child: MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context)=> SplashScreen(),
        HomeScreen.id: (context)=> HomeScreen(),
        WelcomeScreen.id: (context)=> WelcomeScreen(),
        MapScreen.id: (context)=> MapScreen(),
        SignIn.id: (context)=> SignIn(),
        VerificationScreen.id: (context)=> VerificationScreen(),
        MenuScreen.id: (context)=> MenuScreen()
      },
    );
  }
}



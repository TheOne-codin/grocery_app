import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/screens/admin/admin_screen/admin_screen.dart';
import 'package:grocery_app/screens/home_screen.dart';
import 'package:grocery_app/screens/vendor/add_products.dart';
import 'package:grocery_app/screens/vendor/manage_products.dart';
import 'package:grocery_app/screens/vendor/vendor_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: VendorScreen.id,
      routes:{
        VendorScreen.id: (context) => VendorScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        AddProducts.id: (context)=> AddProducts(),
        ManageProducts.id: (context)=> ManageProducts()
      },
    );
  }
}

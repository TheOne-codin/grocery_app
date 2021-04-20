import 'package:flutter/material.dart';
import 'package:grocery_app/Universals/floatingActionButton.dart';

class VendorScreen extends StatefulWidget {

  static const String id = 'vendor-screen';

  @override
  _VendorScreenState createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingButton(),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Firebasedata/firebase_data.dart';
import 'package:grocery_app/Universals/floatingActionButton.dart';
import 'package:grocery_app/screens/vendor/add_products.dart';
import 'package:grocery_app/screens/vendor/manage_products.dart';
import 'package:grocery_app/screens/welcome_screen.dart';

class MenuScreen extends StatefulWidget {
  static const String id = 'menu-screen';

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextButton(
                            onPressed: (){

                            },
                          style: ButtonStyle(

                            backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent),
                          ),
                            child: Text(
                             admin!= true ? vendor == true ? 'Orders': 'Your Orders' :'Orders',
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                        ),
                      ),
                      SizedBox(width: 10,),

                      Expanded(
                        child: TextButton(
                          onPressed: (){

                          },
                          style: ButtonStyle(


                              backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent)
                          ),
                          child: Text(
                            admin!= true ? vendor == true ? 'Products': 'Buy Again' :'Customers'
                            ,
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: (){
                            getUserData();
                            admin!= true? vendor == true ? Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ManageProducts())) : Navigator.of(context).pushReplacementNamed(AddProducts.id): Navigator.of(context).pushReplacementNamed(AddProducts.id);
                          },
                          style: ButtonStyle(

                              backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent),
                          ),
                          child: Text(
                              admin!= true ? vendor == true ? 'Manage Products': 'Your Wish List' :'Customers'
                          ,
                            style: TextStyle(
                                color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: TextButton(
                          onPressed: (){

                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent)
                          ),
                          child: Text(
                            'Discount Coupon',
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                  TextButton(
                      onPressed: (){
                        auth.signOut().then((value) =>
                        Navigator.pushReplacementNamed(context, WelcomeScreen.id)
                        );

                      },
                      style: ButtonStyle(

                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(vertical: 0, horizontal: 100.0)
                          ),
                          backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent)
                      ),

                      child: Text('Sign Out',
                      style: TextStyle(
                        color: Colors.white
                      ),
                      ),
                  ),
              ],
              ),
            ),
          ),
      ),
      floatingActionButton: FloatingButton(),

    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Firebasedata/firebase_data.dart';
import 'package:grocery_app/Universals/floatingActionButton.dart';
import 'package:grocery_app/screens/home_screen.dart';
import 'package:grocery_app/screens/vendor/add_products.dart';

class ManageProducts extends StatefulWidget {
  static const String id = 'manageProducts-screen';

  @override
  _ManageProductsState createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProducts> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical:5,horizontal:20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.account_circle,
                      color: Colors.white,
                      size: 40,),
                      backgroundColor: Colors.grey,
                    ),
                    Column(
                      children: [
                        Text(
                          'Manage Products',
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                        TextButton(onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AddProducts()));
                        }, child: Text('Add Product'))
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('Products').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                    if(!snapshot.hasData){
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    return Column(
                       children: snapshot.data.docs.map((doc){
                        return TextButton(
                          onPressed: (){
                            
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    child: Image.network(doc['Image Location']),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          doc['Product Name'],
                                          style: TextStyle(
                                            fontSize:40,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Regular Price: ${doc['Regular Price']}',
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(
                                                "Offer Price: ${doc['Offer Price']}")
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ) ;
                  },
                ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingButton(),
    );
  }
}


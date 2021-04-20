
import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Firebasedata/firebase_data.dart';
import 'package:grocery_app/Universals/floatingActionButton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddProducts extends StatefulWidget {
  static const String id = 'add-products';

  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {

  String productName='', description=''; double regularPrice=0.0, offerPrice=0.0, fac;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Text(
                      '$name',
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),
                  ),
                  Text(
                    'Add Products',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    onChanged: (value){
                      setState(() {
                        productName = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Product Name'
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value){
                            fac = double.parse(value);
                            setState(() {
                              regularPrice = fac * pow(10, 2).round() / pow(10, 2);
                            });
                          },
                          decoration: InputDecoration(
                              hintText: 'Enter Regular Price'
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: TextField(
                            onChanged: (value){
                              fac = double.parse(value);
                              setState(() {
                                offerPrice = fac * pow(10, 2).round() / pow(10, 2);
                              });
                            },
                          decoration: InputDecoration(
                              hintText: 'Enter Offer Price'
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    onChanged: (value){
                      setState(() {
                        description = value;
                      });
                    },
                    maxLength: 600,
                    maxLines: 10,
                    decoration: InputDecoration(
                        hintText: 'Enter Product Description',
                      fillColor: Colors.white70,
                      filled: true
                    ),
                  ),
                  Container(
                    width: 500,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.deepOrangeAccent)
                      ),
                      onPressed: (){
                        uploadImage();
                      },
                      child: Text(
                        'Upload Product Image',
                      style: TextStyle(
                        color: Colors.white
                      ),),
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      onsubmit();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.tealAccent)
                    ),
                      child: Text(
                    'Submit',
                        style: TextStyle(
                          color: Colors.white
                        ),
                  ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingButton(),
    );
  }

  onsubmit(){
    getUserData();
    createProduct(productName, description, regularPrice, offerPrice, imgURL);
  }

  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    
    final _picker = ImagePicker();
    PickedFile image;
    var time = DateTime.now();

    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if(permissionStatus.isGranted){
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);

      if(image!=null){
        var snapshot = await _storage.ref()
            .child('Images/IMG_$time')
            .putFile(file);

        var downloadUrl = await snapshot.ref.getDownloadURL();

        setState(() {
          imgURL = downloadUrl;
        });
        print(imgURL);
      }else{
        return null;
      }


    }else{
      return null;
    }
  }

}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



//Users Collection

String uid;
FirebaseAuth auth = FirebaseAuth.instance;


void createUser(String name, String phoneNumber, String _email, bool admin, bool vendor) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  uid = auth.currentUser.uid.toString();
  await users.doc(uid).set({
    'Name': name,
    'Mobile Number': phoneNumber,
    'Email': _email,
    'uid': uid,
    'admin': admin,
    'vendor': vendor
  });
}

bool admin, vendor;
String name, phoneNumber;

void getUserData() async {
  User user = FirebaseAuth.instance.currentUser;
  uid = user.uid.toString();
  DocumentReference userData = FirebaseFirestore.instance.collection('Users').doc(uid);
  await userData.get().then((value) =>
  {
    vendor = value.data()['vendor'],
    admin = value.data()['admin'],
    name = value.data()['Name'],
    phoneNumber = value.data()['Mobile Number']
  });

}

//Users Collection Ends Here

//Products Collection
void createProduct(String productName, String description, double regularPrice, double offerPrice, String imgURL) async {
  CollectionReference products = FirebaseFirestore.instance.collection('Products');
  await products.doc().set({
    'Product Name': productName,
    'Description': description,
    'Regular Price': regularPrice,
    'Offer Price': offerPrice,
    'Image Location': imgURL,
    'Posted By': name
  });
}

String productName, description,  imgURL; double regularPrice, offerPrice;
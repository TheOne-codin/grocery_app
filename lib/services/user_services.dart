

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_app/models/user_model.dart';

class UserServices{

  String collection = "users";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //create new user

  Future<void> createUserData(Map<String, dynamic>values)async{
    String id = values['id'];
    await _firestore.collection(collection).doc(id).set(values);
  }

  //update User Data

  Future<void> updateUserData(Map<String, dynamic>values) async {
      String id = values['id'];
      await _firestore.collection(collection).doc(id).update(values);
  }

  //get user data by user id

  Future<void> getUserData(String id) async {
    await _firestore.collection(collection).doc(id).get()
        .then((doc) {
          if(doc.data()==null){
            return null;
          }

          return UserModel.fromSnapshot(doc);
    });
  }

}
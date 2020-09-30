import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class UserModel extends ChangeNotifier {
  User user = User(sunNotification: false);

  updateUser(User user) {
    user = user;
    notifyListeners();
  }
}

class User {
  String email;
  String city;
  bool sunNotification;
  auth.User firebaseUser;
  DocumentReference reference;

  User({this.firebaseUser, this.sunNotification})
      : this.email = firebaseUser?.email;

  User.fromSnapshot(DocumentSnapshot snapshot, {auth.User firebaseUser})
      : this.fromData(
          snapshot.data(),
          reference: snapshot.reference,
          firebaseUser: firebaseUser,
        );

  User.fromData(Map<String, dynamic> data,
      {this.reference, this.firebaseUser}) {
    city = data['city'];
    email = data['email'];
    sunNotification = data['sunNotification'] ?? false;
  }

  Map<String, dynamic> toJson() {
    return {
      "city": this.city,
      "email": this.email,
      "sunNotification": this.sunNotification
    };
  }
}

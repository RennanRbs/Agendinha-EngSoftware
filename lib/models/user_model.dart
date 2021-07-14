import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String email;
  String name;

  UserModel({this.email, this.name});

  UserModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    email = snapshot['email'];
    name = snapshot['name'];
  }
}
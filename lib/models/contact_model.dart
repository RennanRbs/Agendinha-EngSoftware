import 'package:cloud_firestore/cloud_firestore.dart';

class ContactModel {
  String email;
  String name;
  String phone;
  String address;
  String cep;
  String id;
  List<String> contactGroup;

  ContactModel(
      {this.email,
        this.name,
        this.phone,
        this.address,
        this.cep,
        this.id,
        this.contactGroup});

  ContactModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    email = snapshot['email'];
    name = snapshot['name'];
    phone = snapshot['phone'];
    address = snapshot['address'];
    cep = snapshot['cep'];
    contactGroup = snapshot['contactGroup'].cast<String>();
    this.id = snapshot.id;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['cep'] = this.cep;
    data['contactGroup'] = this.contactGroup;
    return data;
  }
}
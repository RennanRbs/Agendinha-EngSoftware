import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trabalho_eng_software/models/contact_model.dart';
import 'package:trabalho_eng_software/models/user_model.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection("users").doc(user.email).set({
        "name": user.name,
        "email": user.email,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> getUser(String email) async {
    try {
      DocumentSnapshot _doc = await _firestore.collection("users").doc(email).get();
      return UserModel.fromDocumentSnapshot(_doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<ContactModel> getContactById(String id) async {
    var prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('userMail');
    try {
      DocumentSnapshot _doc = await _firestore.collection("users").doc(email).collection("contacts").doc(id).get();
      return ContactModel.fromDocumentSnapshot(_doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addContact(ContactModel contact) async {
    try {
      var prefs = await SharedPreferences.getInstance();
      var email = prefs.getString('userMail');
      await _firestore
          .collection("users")
          .doc(email)
          .collection("contacts")
          .add({
        'email': contact.email,
        'name': contact.name,
        'phone': contact.phone,
        'address': contact.address,
        'cep': contact.cep,
        'contactGroup': contact.contactGroup
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deleteContact(String contactID) async {
    var prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('userMail');
    try {
      await _firestore
          .collection("users")
          .doc(email)
          .collection("contacts")
          .doc(contactID)
          .delete();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Stream<List<ContactModel>> contactStream(String email) {
    print("Building stream");
    print(email);
    return _firestore
        .collection("users")
        .doc(email)
        .collection("contacts")
        .snapshots()
        .map((QuerySnapshot query) {
          List<ContactModel> retVal = [];
          query.docs.forEach((element) {
            print("Got something");
            retVal.add(ContactModel.fromDocumentSnapshot(element));
          });
          return retVal;
        }
        );
  }

  // TODO: Review this function
  Future<void> updateContact(String contactID, ContactModel updatedContact) async {
    var prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('userMail');
    try {
      _firestore
          .collection("users")
          .doc(email)
          .collection("contacts")
          .doc(contactID)
          .set({
            "address": updatedContact.address,
            "cep": updatedContact.cep,
            "contactGroup": updatedContact.contactGroup,
            "email": updatedContact.email,
            "name": updatedContact.name,
            "phone": updatedContact.phone
          });
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
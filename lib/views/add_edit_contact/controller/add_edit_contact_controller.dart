import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trabalho_eng_software/models/contact_model.dart';
import 'package:trabalho_eng_software/services/database.dart';

class AddEditContactController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController CEPController = TextEditingController();

  RxList<String> contactGroupList = RxList.empty();

  void populateFields(String contactID) async {
    ContactModel currentContact = await Database().getContactById(contactID);
    nameController.text = currentContact.name;
    mailController.text = currentContact.email;
    phoneController.text = currentContact.phone;
    addressController.text = currentContact.address;
    CEPController.text = currentContact.cep;
    for (String s in currentContact.contactGroup) {
      contactGroupList.add(s);
    }
  }
}
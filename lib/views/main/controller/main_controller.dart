import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trabalho_eng_software/models/contact_model.dart';
import 'package:trabalho_eng_software/models/user_model.dart';
import 'package:trabalho_eng_software/services/database.dart';

class MainController extends GetxController {
  Rx<List<ContactModel>> contactList = Rx<List<ContactModel>>([]);

  List<ContactModel> get contacts => contactList.value;

  var isLoading = true.obs;

  ScrollController scrollViewController;
  bool showAppBar = true;
  bool isScrollingDown = false;

  int filterType = -1.obs;
  String filterText;

  void initScrollController(setState) {
    print("initScrollController");
    scrollViewController = new ScrollController();
    scrollViewController.addListener(() {

      if (scrollViewController.position.atEdge) {
        setState(() {});
      }

      if (scrollViewController.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          showAppBar = false;
          setState(() {});
        }
      }

      if (scrollViewController.position.userScrollDirection == ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          showAppBar = true;
          setState(() {});
        }
      }
    });
  }

  void disposeScrollController() {
    scrollViewController.dispose();
    scrollViewController.removeListener(() {});
  }

  void prepareStream() async{
    var prefs = await SharedPreferences.getInstance();
    var userEmail = prefs.getString('userMail');
    print(userEmail == null);
    print("Preparing stream");
    print("Preparing stream with email " + userEmail);
    contactList.bindStream(Database().contactStream(userEmail)); // Stream from firebase
  }

  @override
  void onInit() {
    prepareStream();
  }

  bool filterMatch(ContactModel contact) {
    if (filterType == -1) return true;
    if (filterType == 0) {
      return contact.name.toLowerCase().contains(filterText.toLowerCase());
    } else if (filterType == 1) {
      return contact.email.toLowerCase().contains(filterText.toLowerCase());
    } else if (filterType == 2) {
      for (String group in contact.contactGroup) {
        if (group.toLowerCase() == filterText.toLowerCase()) return true;
      }
      return false;
    } else if (filterType == 3) {
      return contact.address.toLowerCase().contains(filterText.toLowerCase());
    } else {
      return false;
    }
  }
}
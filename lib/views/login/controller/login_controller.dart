import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trabalho_eng_software/models/user_model.dart';
import 'package:trabalho_eng_software/views/main/main_view.dart';

class LoginController extends GetxController {

  LoginController() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  onInit() {
    super.onInit();
    auth.userChanges().listen(_loginAndProceed);
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailController;
  TextEditingController passwordController;

  void _loginAndProceed(User user) async {
    if (user == null) {
      print("User signed out!");
    } else {
      print("User logged in with email " + auth.currentUser.email);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userMail', auth.currentUser.email);
      print(auth.currentUser.email);
      Get.put(UserModel(email: auth.currentUser.email, name: "User"));
      Get.to(() => MainView());
      // Move to next screen
    }
  }

  void tryLogin() async {
    try {
      await auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("Login failed", "No user found with that email");
      } else if (e.code == 'wrong-password') {
        Get.snackbar("Login failed", "Wrong password!");
      }
    }
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trabalho_eng_software/models/user_model.dart';
import 'package:trabalho_eng_software/services/database.dart';

class RegisterController extends GetxController {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
  }

  void register() {
    Database().createNewUser(UserModel(
      name: nameController.text,
      email: emailController.text
    ));
    auth.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
  }
}
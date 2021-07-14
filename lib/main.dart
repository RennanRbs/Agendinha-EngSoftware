import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trabalho_eng_software/views/login/binding/login_binding.dart';
import 'package:trabalho_eng_software/views/login/login_view.dart';
import 'package:trabalho_eng_software/views/main/binding/main_binding.dart';
import 'package:trabalho_eng_software/views/main/main_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: [
        GetPage(name: '/login', page: () => LoginView(), binding: LoginBinding()),
        GetPage(name: '/home', page: () => MainView(), binding: MainBinding())
      ],
      initialRoute: '/login',
    );
  }
}
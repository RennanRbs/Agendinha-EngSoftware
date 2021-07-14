import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trabalho_eng_software/views/register/controller/register_controller.dart';
import 'package:trabalho_eng_software/widgets/custom_rounded_textfield.dart';
import 'package:trabalho_eng_software/widgets/large_button.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  var controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Text('Registro',
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),
          ),
        ),
        shadowColor: Colors.transparent,
        backgroundColor: Color(0xFFFAFAFA),
      ),
      body: Column(
        children: [
          CustomRoundedTextField(upperText: "Nome", controller: controller.nameController,),
          CustomRoundedTextField(upperText: "E-mail", controller: controller.emailController,),
          CustomRoundedTextField(upperText: "Senha", controller: controller.passwordController, obscureText: true,),
          Spacer(),
          LargeButton(
            text: "Confirmar",
            onPressed: () {
              controller.register();
              Get.back();
            },
            color: Colors.orange
          )
        ],
      ),

    );
  }
}

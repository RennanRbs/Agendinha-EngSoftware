import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trabalho_eng_software/views/login/controller/login_controller.dart';
import 'package:trabalho_eng_software/views/register/register_view.dart';
import 'package:trabalho_eng_software/widgets/custom_rounded_textfield.dart';
import 'package:trabalho_eng_software/widgets/large_button.dart';

class LoginView extends StatelessWidget {

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Text("CONTATOS",
            style: GoogleFonts.montserrat(
              fontSize: 37,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          CustomRoundedTextField(upperText: "Nome de usuário", controller: controller.emailController,),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.002,
          ),
          CustomRoundedTextField(upperText: "Senha", controller: controller.passwordController, obscureText: true),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.008,
          ),
          LargeButton(
            color: Colors.orange,
            onPressed: () {
              controller.tryLogin();
            },
            text: "ENTRAR",
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Divider(
              thickness: 2,
            ),
          ),
          Text("Não tem conta?"),
          LargeButton(
            text: "SE REGISTRAR",
            onPressed: () {
              Get.to(() => RegisterView());
            },
            color: Colors.grey[500]
          ),
        ],
      ),
    );
  }
}

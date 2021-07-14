import 'package:get/get.dart';
import 'package:trabalho_eng_software/views/register/controller/register_controller.dart';

class RegisterBinding implements Bindings {

  @override
  void dependencies() {
    Get.put<RegisterController>(RegisterController());
  }

}
import 'package:get/get.dart';
import 'package:trabalho_eng_software/views/main/controller/main_controller.dart';

class MainBinding implements Bindings {

  @override
  void dependencies() {
    Get.put<MainController>(MainController());
  }

}
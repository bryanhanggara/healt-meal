import 'package:get/get.dart';

class LoginController extends GetxController {
  var email = "".obs;
  var password = "".obs;

  void login() {
    if (email.value == "admin" && password.value == "admin") {
      Get.offNamed('/home');
    } else {
      Get.snackbar("Ups!", "email dan password tidak cocok");
    }
  }
}

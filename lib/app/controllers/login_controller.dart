import 'package:get/get.dart';

class LoginController extends GetxController {
  var email = "".obs;
  var password = "".obs;

  void login() {
    if (email.value == "123" && password.value == "123") {
      Get.offNamed('/home');
    } else {
      Get.snackbar("Ups!", "email dan password tidak cocok");
    }
  }
}

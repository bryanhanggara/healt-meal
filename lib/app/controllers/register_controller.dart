import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  void register(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Get.snackbar("Sukses", "Berhasil Membuat Akun");
      Get.offAllNamed('/login');
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        Get.snackbar("Gagal", "Password terlalu lemah!");
      } else if (e.code == "email-already-in-use") {
        Get.snackbar("Gagal", "Email sudah terdaftar!");
      }
      print(e.code);
    } catch (e) {
      print(e);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

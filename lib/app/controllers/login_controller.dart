import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get streamAuthStatus =>
      FirebaseAuth.instance.authStateChanges();

  void login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("email tidak cocok");
        Get.snackbar(
          "Ups!",
          "Email Tidak Ditemukan",
        );
      } else if (e.code == 'wrong-password') {
        print("password tidak cocok");
        Get.snackbar(
          "Ups!",
          "Password Salah",
        );
      } else if (e.code == 'too-many-request') {
        print("terlalu banyak mencoba");
        Get.snackbar(
          "Sudah dulu ya!",
          "Terlalu banyak mencoba, ingat ingat lagi!",
        );
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

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myapp/app/controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    final RegisterController registerController = Get.find();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(35),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    child: Image.asset(
                      'assets/images/login.jpg',
                      height: 200,
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Text(
                "Register",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Icon(Icons.email_outlined, color: Colors.grey),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: registerController.emailController,
                      decoration: InputDecoration(
                          hintText: "Email",
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          )),
                      maxLines: 1,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Icon(Icons.password_outlined, color: Colors.grey),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      controller: registerController.passwordController,
                      decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.visibility_off_outlined,
                            color: Colors.grey,
                          ),
                          hintText: "Password",
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          )),
                      maxLines: 1,
                      obscureText: true,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Dengan registrasi kamu menyetujui syarat dan ketentuan aplikasi",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    registerController.register(
                      registerController.emailController.text,
                      registerController.passwordController.text,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Daftar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Get.toNamed('/login');
                  },
                  child: Text("Sudah Punya Akun? Login"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

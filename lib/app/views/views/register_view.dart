import 'package:flutter/material.dart';

import 'package:get/get.dart';

class RegisterView extends GetView {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    var loginController;
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
                      onChanged: (value) => loginController.email.value = value,
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
                      onChanged: (value) =>
                          loginController.password.value = value,
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
                    loginController.login();
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

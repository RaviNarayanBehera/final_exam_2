import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/components/auth_controller.dart';
import '../services/auth_service.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage('https://img.freepik.com/free-vector/gradient-connection-background_52683-116380.jpg?semt=ais_hybrid',),fit: BoxFit.cover)
        ),
        child: AlertDialog(
          shadowColor: Colors.black,
          backgroundColor: Colors.transparent,
          title: const Center(child: Text('Welcome Back', style: TextStyle(color: Colors.white))),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller.txtEmail,
                    decoration: const InputDecoration(labelText: "Email", labelStyle: TextStyle(color: Colors.white)),
                    style: const TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: controller.txtPassword,
                    decoration: const InputDecoration(labelText: "Password", labelStyle: TextStyle(color: Colors.white)),
                    style: const TextStyle(color: Colors.white),
                    obscureText: true,
                  ),
                  const SizedBox(height: 25),
                  TextButton(
                    onPressed: () {
                      Get.offAndToNamed('/signUp');
                      controller.txtEmail.clear();
                      controller.txtPassword.clear();
                    },
                    child: const Center(
                      child: Text(
                        "Don't have an account? Sign Up        ",
                        style: TextStyle(color: Colors.white, fontSize: 13, letterSpacing: 0.8, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.white),
                    ),
                    onPressed: () async {
                      String email = controller.txtEmail.text;
                      String password = controller.txtPassword.text;

                      if (email.isEmpty || password.isEmpty) {
                        Get.snackbar('Validation Error', 'Email and password cannot be empty');
                        return;
                      }

                      String response = await AuthService.authService.signInWithEmailAndPassword(
                        email,
                        password,
                      );

                      if (response == "Login Success") {
                        Get.offAndToNamed('/home');
                      } else {
                        Get.snackbar('Sign In Failed!', response);
                      }
                    },
                    child: const Text('Sign In', style: TextStyle(color: Colors.black)),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

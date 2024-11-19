import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/components/auth_controller.dart';
import '../services/auth_service.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     'Sign Up',
      //     style: TextStyle(
      //       color: Colors.black,
      //       fontSize: 23,
      //       fontWeight: FontWeight.w500,
      //       letterSpacing: 1.5,
      //     ),
      //   ),
      //   flexibleSpace: Container(
      //     decoration: const BoxDecoration(
      //      color: Colors.deepPurpleAccent
      //     ),
      //   ),
      // ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage('https://img.freepik.com/free-vector/gradient-connection-background_52683-116380.jpg?semt=ais_hybrid',),fit: BoxFit.cover)
        ),
        child: AlertDialog(
          shadowColor: Colors.black,
          backgroundColor: Colors.transparent,
          title: const Center(child: Text('Create Account', style: TextStyle(color: Colors.white))),
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
                  TextField(
                    controller: controller.txtConfirmPassword,
                    decoration: const InputDecoration(labelText: "Confirm Password", labelStyle: TextStyle(color: Colors.white)),
                    style: const TextStyle(color: Colors.white),
                    obscureText: true,
                  ),
                  const SizedBox(height: 25),
                  TextButton(
                    onPressed: () {
                      Get.offAndToNamed('/signIn');
                      controller.txtEmail.clear();
                      controller.txtPassword.clear();
                      controller.txtConfirmPassword.clear();
                    },
                    child: const Center(
                      child: Text(
                        "Already have an account? Sign In        ",
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
                      String confirmPassword = controller.txtConfirmPassword.text;

                      // Validate input
                      if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
                        Get.snackbar('Validation Error', 'Please fill in all fields');
                        return;
                      }

                      if (password != confirmPassword) {
                        Get.snackbar('Validation Error', 'Passwords do not match');
                        return;
                      }

                      // Call Firebase sign-up method
                      String response = await AuthService.authService.createAccountWithEmailAndPassword(email, password);
                      if (response == "Account Created Successfully") {
                        Get.offAndToNamed('/home');
                      } else {
                        Get.snackbar('Sign Up Failed!', response);
                      }
                    },
                    child: const Text('Sign Up', style: TextStyle(color: Colors.black)),
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

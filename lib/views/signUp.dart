import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/components/auth_controller.dart';
import '../modal/user_model.dart';
import '../services/auth_service.dart';
import '../services/cloud_firestore_service.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFa13efd),
              Color(0xFF7247f9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: AlertDialog(
          shadowColor: Colors.black,
          backgroundColor: Colors.transparent,
          title: const Center(
              child: Text('Create Account',
                  style: TextStyle(color: Colors.white))),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller.txtEmail,
                    decoration: const InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.white)),
                    style: const TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: controller.txtPassword,
                    decoration: const InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.white)),
                    style: const TextStyle(color: Colors.white),
                    obscureText: true,
                  ),
                  TextField(
                    controller: controller.txtConfirmPassword,
                    decoration: const InputDecoration(
                        labelText: "Confirm Password",
                        labelStyle: TextStyle(color: Colors.white)),
                    style: const TextStyle(color: Colors.white),
                    obscureText: true,
                  ),
                  const SizedBox(height: 25),
                  TextButton(
                    onPressed: () {
                      Get.offAndToNamed('/signIn');
                      // Clear the controllers when navigating
                      controller.txtEmail.clear();
                      controller.txtPassword.clear();
                      controller.txtConfirmPassword.clear();
                    },
                    child: const Center(
                      child: Text(
                        "Already have an account? Sign In        ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            letterSpacing: 0.8,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white)),
                    onPressed: () async {
                      if (controller.txtPassword.text ==
                          controller.txtConfirmPassword.text) {
                        await AuthServices.authService
                            .createAccountWithEmailAndPassword(
                          controller.txtEmail.text,
                          controller.txtPassword.text,
                        );

                        UserModel user = UserModel(
                          name: controller.txtName.text,
                          email: controller.txtEmail.text,
                        );

                        await CloudFireStoreService.cloudFireStoreService
                            .insertUserIntoFireStore(user);
                        Get.offAndToNamed('/signIn');

                        controller.txtEmail.clear();
                        controller.txtPassword.clear();
                        controller.txtName.clear();
                        controller.txtConfirmPassword.clear();
                        controller.txtPhone.clear();
                      }
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.black),
                    ),
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

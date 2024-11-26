import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../views/signIn.dart';
import '../views/signUp.dart';

class AuthManager extends StatelessWidget {
  const AuthManager({super.key});

  @override
  Widget build(BuildContext context) {
    return (AuthServices.authService.getCurrentUser()==null)
        ? const SignIn()
        : const SignUp();
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth/auth_manager.dart';
import 'views/signIn.dart';
import 'views/signUp.dart';
import 'firebase_options.dart';
import 'views/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/',
          page: () => const AuthManager(),
        ),
        GetPage(
          name: '/signIn',
          page: () => const SignIn(),
        ),
        GetPage(
          name: '/signUp',
          page: () => const SignUp(),
        ),
        GetPage(
          name: '/home',
          page: () =>  InventoryPage(),
        ),
      ],
    );
  }
}


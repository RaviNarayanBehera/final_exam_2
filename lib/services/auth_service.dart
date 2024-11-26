// import 'dart:developer';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class AuthService {
//   AuthService._();
//   static final AuthService authService = AuthService._();
//
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//
//   // Create Account
//   Future<String> createAccountWithEmailAndPassword(String email, String password) async {
//     try {
//       await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
//       // Send email verification after creating the account
//       await sendEmailVerification();
//       return "Account Created Successfully. Please verify your email.";
//     } on FirebaseAuthException catch (e) {
//       switch (e.code) {
//         case 'email-already-in-use':
//           return "The email address is already in use by another account.";
//         case 'invalid-email':
//           return "The email address is not valid.";
//         case 'weak-password':
//           return "The password is too weak.";
//         default:
//           return "Error: ${e.message}";
//       }
//     } catch (e) {
//       return e.toString();
//     }
//   }
//
//   // Login
//   Future<String> signInWithEmailAndPassword(String email, String password) async {
//     try {
//       await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
//       return "Login Success";
//     } on FirebaseAuthException catch (e) {
//       switch (e.code) {
//         case 'user-not-found':
//           return "No user found for that email.";
//         case 'wrong-password':
//           return "Wrong password provided.";
//         case 'user-disabled':
//           return "The user account has been disabled.";
//         default:
//           return "Error: ${e.message}";
//       }
//     } catch (e) {
//       return e.toString();
//     }
//   }
//
//   // Sign Out
//   Future<void> signOutUser() async {
//     try {
//       await _firebaseAuth.signOut();
//     } catch (e) {
//       log("Error signing out: $e");
//     }
//   }
//
//   // Get Current User
//   User? getCurrentUser() {
//     User? user = _firebaseAuth.currentUser;
//     if (user != null) {
//       log("Current user email: ${user.email}");
//     }
//     return user;
//   }
//
//   // Reset Password
//   Future<String> resetPassword(String email) async {
//     try {
//       await _firebaseAuth.sendPasswordResetEmail(email: email);
//       return "Password reset email sent";
//     } on FirebaseAuthException catch (e) {
//       switch (e.code) {
//         case 'user-not-found':
//           return "No user found for that email.";
//         case 'invalid-email':
//           return "The email address is not valid.";
//         default:
//           return "Error: ${e.message}";
//       }
//     } catch (e) {
//       return e.toString();
//     }
//   }
//
//   // Send Email Verification
//   Future<void> sendEmailVerification() async {
//     User? user = _firebaseAuth.currentUser;
//     if (user != null && !user.emailVerified) {
//       try {
//         await user.sendEmailVerification();
//         log("Verification email sent to ${user.email}");
//       } catch (e) {
//         log("Error sending verification email: $e");
//       }
//     }
//   }
// }
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthServices
{
  AuthServices._();
  static AuthServices authService = AuthServices._();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Create Account
  Future<void> createAccountWithEmailAndPassword(String email, String password)
  async {
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }


  // Login

  Future<String> signInWithEmailAndPassword(String email, String password)
  async {
    try
    {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Success";
    }catch(e)
    {
      return e.toString();
    }
  }


  //Sign Out
  Future<void> signOutUser()
  async {
    await _firebaseAuth.signOut();
  }

  // get current user
  User? getCurrentUser()
  {
    User? user = _firebaseAuth.currentUser;
    if(user!=null)
    {
      log("email : ${user.email}");
    }
    return user;
  }
}
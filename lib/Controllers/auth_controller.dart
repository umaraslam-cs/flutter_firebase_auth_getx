import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_new/Views/Auth/login_page.dart';
import 'package:firebase_auth_new/Views/User/user_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;
  var selectedIndex = 0;
  var email = "";
  var password = "";
  var confirmPassword = "";
  var newPassword = "";
  var tabIndex = 0;

  @override
  void onClose() {
    // TODO: implement onClose
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    newPasswordController.dispose();
    super.onClose();
  }

  clearValues(){
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    newPasswordController.clear();
  }

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password,);
      Get.to(() =>  UserPage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'No User Found for that Email', backgroundColor: Colors.red, colorText: Colors.white,);
      } else if (e.code == 'wrong-password') {
        Get.snackbar("Error", "Wrong Password Provided by User", backgroundColor: Colors.red, colorText: Colors.white,);
      }
    }
  }

  registration() async {
    if (password == confirmPassword) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password, );
        print(userCredential);
        Get.snackbar('Success', 'User Registered Successfully', backgroundColor: Colors.green, colorText: Colors.white,);
        clearValues();
        Get.to(()=> LoginPage());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {

          Get.snackbar('Error', 'Password Provided is too Weak', backgroundColor: Colors.red, colorText: Colors.white,);

        } else if (e.code == 'email-already-in-use') {

          Get.snackbar('Error', 'Account Already exists', backgroundColor: Colors.red, colorText: Colors.white,);

        }
      }
    } else {
      Get.snackbar('Error', 'Password and Confirm Password doesn''t match', backgroundColor: Colors.red, colorText: Colors.white,);

    }
  }

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.snackbar('Success', 'Password Reset Email has been sent !', backgroundColor: Colors.green, colorText: Colors.white,);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'No user found for that email.', backgroundColor: Colors.red, colorText: Colors.white,);

      }
    }
  }

  changePassword() async {
    try {
      await currentUser!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      clearValues();
      Get.to(()=> LoginPage());
      Get.snackbar('Success', 'Your Password has been Changed. Login again!', backgroundColor: Colors.green, colorText: Colors.white,);
    } catch (e) {
      null;
    }
  }

  changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

}

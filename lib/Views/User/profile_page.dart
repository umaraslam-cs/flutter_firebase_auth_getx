import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_new/Controllers/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final AuthController authController = Get.put(AuthController());
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final currentEmail = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: [
          Text(
            'ID: ${uid}\n',
            style: const TextStyle(fontSize: 18.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Email: $currentEmail',
                style: const TextStyle(fontSize: 18.0),
              ),

            ],
          ),

          currentUser!.emailVerified
              ? const Text(
                  'Verified',
                  style: TextStyle(fontSize: 16.0, color: Colors.blueGrey),
                )
              : TextButton(
                  onPressed: () => {
                    print(currentUser!.emailVerified),
                    verifyEmail()},
                  child: const Text('Verify Email')),
          Text(
            '\nCreated: ' '$creationTime',
            style: const TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
  verifyEmail() async {
    if (currentUser != null && !currentUser!.emailVerified) {
      await currentUser!.sendEmailVerification();
      Get.snackbar('Success', 'Verification Email has benn sent',
        backgroundColor: Colors.teal, colorText: Colors.white,);
    }
  }
}

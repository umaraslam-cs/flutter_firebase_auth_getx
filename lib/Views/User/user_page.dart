import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_new/Controllers/auth_controller.dart';
import 'package:firebase_auth_new/Views/Auth/login_page.dart';
import 'package:firebase_auth_new/Views/User/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'change_password_page.dart';
import 'dashboard_page.dart';

class UserPage extends StatelessWidget {
  UserPage({Key? key}) : super(key: key);
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Welcome User"),
                ElevatedButton(
                  onPressed: () async => {
                    await FirebaseAuth.instance.signOut(),
                    authController.clearValues(),
                 Get.to(()=>LoginPage()),
                  },
                  child: const Text('Logout'),
                  style: ElevatedButton.styleFrom(primary: Colors.teal.shade700),
                )
              ],
            ),
          ),
          body: IndexedStack(
            index: authController.tabIndex,
            children: [
              const DashboardPage(),
              ProfilePage(),
              ChangePasswordPage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex,
            items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'My Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Change Password',
              ),

            ],
          ),
        );
      },
    );
  }
}

// class UserPage extends StatelessWidget {
//   UserPage({Key? key}) : super(key: key);
//
//
// final AuthController authController = Get.put(AuthController());
//
//
//   static List<Widget> _widgetOptions = <Widget>[
//     DashboardPage(),
//     ProfilePage(),
//     ChangePasswordPage(),
//   ];
//
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AuthController>(
//       builder: (controller) {
//         return Scaffold(
//           appBar: AppBar(
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text("Welcome User"),
//                 ElevatedButton(
//                   onPressed: () async => {
//                     await FirebaseAuth.instance.signOut(),
//                     authController.clearValues(),
//                  Get.to(()=>LoginPage()),
//                   },
//                   child: Text('Logout'),
//                   style: ElevatedButton.styleFrom(primary: Colors.teal.shade700),
//                 )
//               ],
//             ),
//           ),
//           body: _widgetOptions.elementAt(authController.selectedIndex),
//           bottomNavigationBar: BottomNavigationBar(
//             items: const <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 label: 'Dashboard',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.person),
//                 label: 'My Profile',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.settings),
//                 label: 'Change Password',
//               ),
//             ],
//             currentIndex: authController.selectedIndex,
//             selectedItemColor: Colors.tealAccent.shade700,
//             onTap: authController.onItemTapped(authController.selectedIndex),
//           ),
//         );
//       }
//     );
//   }
// }
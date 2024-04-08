import 'package:carry_cart_app/components/admin_dashboard.dart';
import 'package:carry_cart_app/components/signin_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'my_textformfield.dart';

class AdminLoginPage extends StatefulWidget {
  AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  // final FirebaseAuthServices _auth = FirebaseAuthServices();
  //Text editing controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final String adminEmail = 'techsolutions@gmail.com';
  final String adminPassword = 'tech123';
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void signInAdmin() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == adminEmail && password == adminPassword) {
      // Navigate to admin dashboard or perform desired actions for admin
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdminDashBoard(),
        ),
      );
    } else {
      // Show error message for incorrect credentials
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Incorrect email or password.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: const EdgeInsets.only(right: 150),
                  child: Text(
                    "Welcome to",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: const EdgeInsets.only(right: 70),
                  child: Text(
                    "CARRY CART",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Container(
                      width: 200,
                      height: 200,
                      child: Image.asset("assets/images/carrycart logo.png")),
                ),
                SizedBox(
                  height: 30,
                ),
                textformfield(
                  hinttext: 'Email',
                  controller: emailController,
                  obscureText: false,
                ),
                SizedBox(
                  height: 25,
                ),
                textformfield(
                    controller: passwordController,
                    hinttext: 'Password',
                    obscureText: true),
                SizedBox(
                  height: 30,
                ),
                SignInButton(
                  onPressed: signInAdmin,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void adminSignIn() async {
  //   String email = emailController.text.toString();
  //   String password = passwordController.text.toString();
  //
  //   User? user = await _auth.signInWithEmailAndPassword(email, password);
  //   if (user != null) {
  //     print("User is successfully signin:");
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => AdminDashBoard(),
  //       ),
  //     );
  //   } else {
  //     print("Some error happened");
  //   }
  // }
}

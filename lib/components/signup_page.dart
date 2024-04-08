import 'package:carry_cart_app/components/customer_dashboard.dart';
import 'package:carry_cart_app/components/login_page.dart';
import 'package:carry_cart_app/components/signup_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Auth/auth_page.dart';
import 'my_textformfield.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  //Text editing controller
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmpasswordController = TextEditingController();

  final emailController = TextEditingController();
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmpasswordController;
    emailController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                Padding(
                  padding: const EdgeInsets.only(right: 150),
                  child: Text(
                    "Welcome to",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 70),
                  child: Text(
                    "CARRY CART",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Container(
                      width: 200,
                      height: 200,
                      child: Image.asset("assets/images/carrycart logo.png")),
                ),
                textformfield(
                  hinttext: 'Username',
                  controller: usernameController,
                  obscureText: false,
                ),
                SizedBox(
                  height: 25,
                ),
                textformfield(
                  controller: emailController,
                  hinttext: 'Email',
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
                  height: 25,
                ),
                textformfield(
                  controller: confirmpasswordController,
                  hinttext: 'Confirm Password',
                  obscureText: true,
                ),
                SizedBox(
                  height: 20,
                ),
                SignUpButton(
                  onPressed: signUp,
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  child: Text(
                    "or LOGIN",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUp() async {
    String username = usernameController.text.toString();
    String email = emailController.text.toString();
    String password = passwordController.text.toString();
    String confirmpassword = confirmpasswordController.text.toString();
    User? user = await _auth.signUpWithEmailAndPassword(email, password);
    if (user != null) {
      print("User is successfully created:");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CustomerBoard(),
        ),
      );
    } else {
      print("Some error happened");
    }
  }
}

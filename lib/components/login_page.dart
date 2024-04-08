import 'package:carry_cart_app/components/customer_dashboard.dart';
import 'package:carry_cart_app/components/signin_button.dart';
import 'package:carry_cart_app/components/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Auth/auth_page.dart';
import 'my_textformfield.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  //Text editing controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
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
                  onPressed: signIn,
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(),
                      ),
                    );
                  },
                  child: Text(
                    "or SIGNUP",
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

  void signIn() async {
    String email = emailController.text.toString();
    String password = passwordController.text.toString();

    User? user = await _auth.signInWithEmailAndPassword(email, password);
    if (user != null) {
      print("User is successfully signin:");
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

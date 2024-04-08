import 'dart:async';

import 'package:carry_cart_app/components/selection_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds:3), () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SelectionPage()));
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height *1,
        width: MediaQuery.of(context).size.width *1,
        color: Colors.orange,
        child: Center(
          child: //Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
           // children: [
              Image.asset("assets/images/carrycart logo.png"),
              //Text("CarryCart.shop", style: TextStyle(
               //   fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),)
           // ],
          //),
        ),
      )
    );
  }
}

import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  SignInButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.orange,
          elevation: 15, // Shadow elevation
          shadowColor: Colors.black, // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0), // Border radius
            side: BorderSide(color: Colors.white), // Border color
          ),
        ),
        child: Text(
          'LOGIN',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

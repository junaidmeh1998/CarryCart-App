import 'package:flutter/material.dart';

class PrintBillButton extends StatelessWidget {
  const PrintBillButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.red,
          elevation: 15, // Shadow elevation
          shadowColor: Colors.black, // Text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0), // Border radius
            side:const BorderSide(color: Colors.white), // Border color
          ),
        ),
        child:const Text(
          'PRINT BILL',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

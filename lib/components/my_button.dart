import 'package:flutter/material.dart';


class MyButton extends StatelessWidget {

  final String text;

  MyButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        padding: EdgeInsets.only(top:15, bottom: 15, left: 100, right: 100),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade600
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      
        child: Text(text),
      ),
    );
  }
}



import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keybordType;
  final bool isPassword;

  const CustomInput(
      {
        super.key, 
        required this.icon, 
        required this.placeholder, 
        required this.textController, 
        this.keybordType = TextInputType.text, 
        this.isPassword = false
      }
    );


  @override
  Widget build(BuildContext context) {
    return Container(
            padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54.withValues(alpha: 0.05),
                  offset: Offset(0, 5),
                  blurRadius: 5
                )
              ]
            ),
            child: TextField(
              autocorrect: false,
              keyboardType: keybordType,
              controller: textController,
              obscureText: isPassword,
              decoration: InputDecoration(
                prefixIcon: Icon(icon),
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: placeholder
              ),
            ),
          );
  }
}
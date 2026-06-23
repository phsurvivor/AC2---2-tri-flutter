import 'package:flutter/material.dart';

  Widget Text_custom(String text) {
    return Column(
      children: [
        Text(text, style: TextStyle(fontSize: 15, color: Colors.black)),
        SizedBox(height: 20,)
      ],
    );
  }


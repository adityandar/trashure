import 'package:flutter/material.dart';

class BackClickable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        size: 32,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}

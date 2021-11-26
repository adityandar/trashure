import 'package:flutter/material.dart';
import 'package:trashure_new/misc/trashure_icons.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        Trashure.logo,
        size: 115,
        color: Colors.white,
      ),
      color: Theme.of(context).primaryColor,
    );
  }
}

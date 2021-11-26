import 'package:flutter/material.dart';
import 'package:trashure_new/components/back_clickable.dart';
import 'package:trashure_new/constants.dart';

class HeaderWithIcon extends StatelessWidget {
  HeaderWithIcon(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 78,
      decoration: kCircularHomeContainer.copyWith(
        color: Colors.white,
      ),
      child: Row(
        children: [
          BackClickable(),
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF416188),
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}

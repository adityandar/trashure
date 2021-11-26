import 'package:flutter/material.dart';
import 'package:trashure_new/constants.dart';

class HeaderTitle extends StatelessWidget {
  HeaderTitle(this.title);

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
          SizedBox(width: 16),
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

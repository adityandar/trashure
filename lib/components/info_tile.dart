import 'package:flutter/material.dart';
import 'package:trashure_new/constants.dart';

class InfoTile extends StatelessWidget {
  InfoTile({this.icon, this.title, this.info});

  final IconData icon;
  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            size: 40,
            color: Theme.of(context).primaryColor,
          ),
          Text(
            title,
            style: kGreyTextProfile,
          ),
          SizedBox(height: 3),
          Text(
            info,
            style: TextStyle(
              color: Color(0xFF416188),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

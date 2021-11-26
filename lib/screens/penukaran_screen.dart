import 'package:flutter/material.dart';
import 'package:trashure_new/components/header_title.dart';
import 'package:trashure_new/constants.dart';
import 'package:trashure_new/screens/pulsa_screen.dart';

class PenukaranScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HeaderTitle('Penukaran'),
            SizedBox(height: 46),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  PenukaranTile(
                    icon: Icon(
                      Icons.phone_android,
                      size: 40,
                    ),
                    title: 'Pulsa',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PulsaScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PenukaranTile extends StatelessWidget {
  PenukaranTile({this.icon, this.title, this.onTap});

  final Widget icon;
  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Container(
          height: 80,
          width: double.maxFinite,
          decoration: kCircularHomeContainer,
          padding: EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              icon,
            ],
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:trashure_new/constants.dart';

class NotificationTile extends StatelessWidget {
  final bool read;
  final Widget icon;
  final String title;
  final String desc;
  final String time;

  NotificationTile({this.read, this.desc, this.icon, this.time, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 63,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              icon,
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(title),
                  Text(
                    desc,
                    style: kLightTextNotification,
                  ),
                ],
              ),
            ],
          ),
          (!read)
              ? Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                      color: Color(0xFFFF5722), shape: BoxShape.circle),
                )
              : Text(
                  time,
                  style:
                      kLightTextNotification.copyWith(color: Color(0x4D000000)),
                ),
        ],
      ),
    );
  }
}

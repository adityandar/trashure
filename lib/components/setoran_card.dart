import 'package:flutter/material.dart';
import 'package:trashure_new/code/change_date.dart';
import 'package:trashure_new/constants.dart';

class SetoranCard extends StatelessWidget {
  SetoranCard({this.trashbagID, this.date, this.finished});

  final String trashbagID;
  final int date;
  final bool finished;

  @override
  Widget build(BuildContext context) {
    final String time = changeDate(date);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      height: 76,
      width: double.maxFinite,
      decoration: kCircularHomeContainer,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 52,
            height: 52,
            color: Theme.of(context).primaryColor,
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 40,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Trashbag ID #'),
                        Text(
                          trashbagID,
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                    Text(
                      time,
                    ),
                  ],
                ),
                Text(
                  (finished) ? 'Selesai' : 'Proses',
                  style:
                      TextStyle(color: (finished) ? Colors.green : Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

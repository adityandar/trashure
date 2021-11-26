import 'package:flutter/material.dart';
import 'package:trashure_new/code/cut_text.dart';
import 'package:trashure_new/components/header_with_icon.dart';
import 'package:trashure_new/components/notification_tile.dart';
import 'package:trashure_new/constants.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int _idx = 0;
  bool _read = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16, 150, 16, 0),
              child: Column(
                children: [
                  NotificationTile(
                    read: _read,
                    title: 'Penukaran Pulsa',
                    time: '20.50',
                    desc: cutText(41,
                        'Pulsa sebesar 5000 dengan nomor kartu Tri 08992220222 berhasil ditukar kan. Sisa saldo anda sebesar Rp. 144.000'),
                    icon: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      child: Icon(
                        Icons.phone_android,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  NotificationTile(
                    read: _read,
                    title: 'Pesan masuk',
                    time: '24/10/2019',
                    desc: 'Maudy Ayunda mengirim pesan',
                    icon: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      child: Icon(
                        Icons.message,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                HeaderWithIcon('Notifikasi'),
                Column(
                  children: [
                    SizedBox(height: 78),
                    Container(
                      height: 56,
                      decoration: kCircularHomeContainer.copyWith(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x20808080),
                            spreadRadius: 0,
                            blurRadius: 8,
                            offset: Offset(0, 10), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: FlatButton(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'NOTIFIKASI',
                                      style: TextStyle(
                                        color: (_idx == 0)
                                            ? Colors.black
                                            : Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Container(
                                      width: 800,
                                      height: 3,
                                      color: (_idx == 0)
                                          ? Theme.of(context).primaryColor
                                          : Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  _idx = 0;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: FlatButton(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'LAINNYA',
                                      style: TextStyle(
                                        color: (_idx == 1)
                                            ? Colors.black
                                            : Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Container(
                                      width: 205,
                                      height: 3,
                                      color: (_idx == 1)
                                          ? Theme.of(context).primaryColor
                                          : Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  _idx = 1;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

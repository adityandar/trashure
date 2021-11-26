import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trashure_new/components/header_with_icon.dart';
import 'package:trashure_new/constants.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Column(
            children: [
              HeaderWithIcon('Penukaran Pulsa'),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 26, 16, 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Penukaran Pulsa',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '25/06/2019',
                          style: kLightTextNotification.copyWith(
                              color: Color(0x4D000000)),
                        ),
                      ],
                    ),
                    SizedBox(height: 26),
                    Text(
                      'Pulsa sebesar 5000 dengan nomor kartu Tri 08992220222 berhasil ditukar kan. Sisa saldo anda sebesar Rp. 144.000',
                      style: kLightTextNotification,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

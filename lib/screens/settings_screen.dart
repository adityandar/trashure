import 'package:flutter/material.dart';
import 'package:trashure_new/components/custom_divider.dart';
import 'package:trashure_new/components/header_with_icon.dart';

class SettingsScreen extends StatelessWidget {
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      body: SafeArea(
        child: Column(
          children: [
            HeaderWithIcon('Pengaturan'),
            GestureDetector(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Container(
                    height: 141,
                    width: double.maxFinite,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 29),
                            Icon(Icons.translate, size: 24),
                            SizedBox(width: 39),
                            Text('Ganti Bahasa',
                                style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        CustomDivider(),
                        Row(
                          children: [
                            SizedBox(width: 29),
                            Icon(Icons.notifications, size: 24),
                            SizedBox(width: 39),
                            Text('Notifikasi', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 279,
                    width: double.maxFinite,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 29),
                            Icon(Icons.help, size: 24),
                            SizedBox(width: 39),
                            Text('Bantuan', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        CustomDivider(),
                        Row(
                          children: [
                            SizedBox(width: 29),
                            Icon(Icons.lock, size: 24),
                            SizedBox(width: 39),
                            Text('Kebijakan Privasi',
                                style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        CustomDivider(),
                        Row(
                          children: [
                            SizedBox(width: 29),
                            Icon(Icons.assignment, size: 24),
                            SizedBox(width: 39),
                            Text('Ketentuan Layanan',
                                style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        CustomDivider(),
                        Row(
                          children: [
                            SizedBox(width: 29),
                            Icon(Icons.star, size: 24),
                            SizedBox(width: 39),
                            Text('Beri Kami Nilai',
                                style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              onTap: () {
                final snackBar = SnackBar(content: Text('Coming Soon'));
                globalKey.currentState.showSnackBar(snackBar);
              },
            ),
          ],
        ),
      ),
    );
  }
}

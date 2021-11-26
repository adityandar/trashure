import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashure_new/components/header_title.dart';
import 'package:trashure_new/constants.dart';
import 'package:trashure_new/misc/trashure_icons.dart';
import 'package:trashure_new/models/profile_provider.dart';

class ConnectedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            HeaderTitle('Scan'),
            Center(
              child: Container(
                width: 377,
                height: 498,
                decoration: kCircularHomeContainer,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Trashbag dengan ID 4TT4K323N\nmasih terhubung',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    Icon(
                      Trashure.trashbag,
                      color: Theme.of(context).primaryColor,
                      size: 124,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 31),
                      child: ElevatedButton(
                        child: Text('Putuskan sambungan'),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFFF5722),
                        ),
                        onPressed: () {
                          Provider.of<ProfileProvider>(context, listen: false)
                              .connectedTrashbag = null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashure_new/components/header_title.dart';
import 'package:trashure_new/components/info_tile.dart';
import 'package:trashure_new/constants.dart';
import 'package:trashure_new/models/profile_provider.dart';
import 'package:trashure_new/screens/edit_screen.dart';
import 'package:trashure_new/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<ProfileProvider>(
          builder: (context, profile, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HeaderTitle('Akun'),
                SizedBox(height: 44),
                Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            decoration: kCircularHomeContainer,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            height: 565,
                            width: double.maxFinite,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(height: 35),
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    size: 14,
                                    color: Color(0x4D000000),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditScreen()));
                                  },
                                ),
                                Text(
                                  profile.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF416188),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  height: 131,
                                  width: 351,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InfoTile(
                                        icon: Icons.star,
                                        title: 'Level',
                                        info: profile.getLevel(),
                                      ),
                                      InfoTile(
                                        icon: Icons.payment,
                                        title: 'Saldo',
                                        info: "Rp ${profile.balance}",
                                      ),
                                      InfoTile(
                                        icon: Icons.delete,
                                        title: 'Total',
                                        info: '${profile.total} kg',
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 27),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  width: double.maxFinite,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Nomor HP',
                                        style: kGreyTextProfile,
                                      ),
                                      SizedBox(height: 10),
                                      Text(profile.noHP),
                                      SizedBox(height: 30),
                                      Text(
                                        'Email',
                                        style: kGreyTextProfile,
                                      ),
                                      SizedBox(height: 10),
                                      Text(profile.email),
                                      SizedBox(height: 30),
                                      Text(
                                        'Tanggal Lahir',
                                        style: kGreyTextProfile,
                                      ),
                                      SizedBox(height: 10),
                                      Text((profile.ttl != null)
                                          ? profile.ttl
                                          : "-"),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 27),
                                ElevatedButton(
                                  child: Text('KELUAR'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFFFF5722),
                                  ),
                                  onPressed: () {
                                    profile.logOut();
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()),
                                      (Route<dynamic> route) => false,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/images/ava.png'),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

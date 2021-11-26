import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashure_new/models/profile_provider.dart';
import 'package:trashure_new/screens/connected_screen.dart';
import 'package:trashure_new/screens/home_screen.dart';
import 'package:trashure_new/screens/login_screen.dart';
import 'package:trashure_new/screens/penukaran_screen.dart';
import 'package:trashure_new/screens/profile_screen.dart';
import 'package:trashure_new/screens/scan_screen.dart';
import 'package:trashure_new/screens/trash_prices.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeScreen(),
    PenukaranScreen(),
    ScanScreen(),
    TrashPrices(),
    ProfileScreen(),
    ConnectedScreen()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    final _profile = Provider.of<ProfileProvider>(context, listen: false);
    if (_profile.id == -1) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: 800,
          width: double.maxFinite,
          child: _children[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        selectedItemColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.payment), label: 'Penukaran'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Scan'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_offer), label: 'Harga'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
        ],
      ),
    );
  }
}

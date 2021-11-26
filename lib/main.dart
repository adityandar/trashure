import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashure_new/models/profile_provider.dart';
import 'package:trashure_new/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileProvider>(
      create: (context) => ProfileProvider(),
      child: MaterialApp(
        title: 'Trashure',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xFF8BC34A),
          accentColor: Color(0XFFFF5722),
          backgroundColor: Color(0xFFF8F8F8),
          fontFamily: "SFPro",
          visualDensity: VisualDensity.adaptivePlatformDensity,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all<Size>(Size(56, 56)),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xFF8BC34A)),
            ),
          ),
        ),
        home: LoginScreen(),
      ),
    );
  }
}

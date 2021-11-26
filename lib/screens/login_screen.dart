import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashure_new/api/api_service.dart';
import 'package:trashure_new/misc/trashure_icons.dart';
import 'package:trashure_new/models/profile.dart';
import 'package:trashure_new/models/profile_provider.dart';
import 'package:trashure_new/screens/main_screen.dart';
import 'package:trashure_new/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  ApiService _apiService = ApiService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.maxFinite,
              height: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Form(
                key: _formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          // Logo with Text
                          children: [
                            Icon(
                              Trashure.logo,
                              color: Theme.of(context).primaryColor,
                              size: 76,
                            ),
                            Text(
                              'Trashure',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 24),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        Column(
                          // Input Forms
                          children: [
                            TextFormField(
                              // Email Input Form
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(),
                              ),
                              textInputAction: TextInputAction.next,
                              // onFieldSubmitted: (v) {
                              //   FocusScope.of(context).nextFocus();
                              // },
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Email can't be empty";
                                } else if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  return 'Please enter valid email address';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 12),
                            TextFormField(
                              // Password Input Form
                              controller: _passwordController,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.remove_red_eye,
                                    color: (!_obscureText)
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(),
                              ),
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Password can't be empty";
                                } else if (value.length < 6) {
                                  return '6 characters minimum';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: false,
                                  onChanged: (v) {},
                                ),
                                Text('Ingat saya'),
                              ],
                            ),
                            GestureDetector(
                              child: Text(
                                'LUPA PASSWORD?',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF416188)),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          child: Text('MASUK'),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              print('valiidate');
                              setState(() {
                                _isLoading = true;
                              });
                              _apiService
                                  .login(_emailController.text,
                                      _passwordController.text)
                                  .then((id) async {
                                setState(() => _isLoading = false);
                                if (id != null) {
                                  print('success');
                                  Profile data =
                                      await _apiService.getProfile(id);
                                  var temp = Provider.of<ProfileProvider>(
                                      context,
                                      listen: false);
                                  temp.id = data.id;
                                  temp.name = data.name;
                                  temp.email = data.email;
                                  temp.noHP = data.no_hp;
                                  temp.setLevel(data.level);
                                  temp.balance = data.balance;
                                  temp.total = data.total;
                                  temp.setTTL(data.ttl);
                                  temp.avatar = data.avatar;
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainScreen()),
                                    (Route<dynamic> route) => false,
                                  );
                                } else {
                                  CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.error,
                                    confirmBtnColor:
                                        Theme.of(context).primaryColor,
                                    text: "Login failed, please try again!",
                                  );
                                }
                              });
                            }
                          },
                        ),
                        SizedBox(height: 24),
                        Column(
                          children: [
                            Text(
                              'atau masuk dengan',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0x32000000),
                              ),
                            ),
                            SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Icon(Trashure.gplus),
                                ),
                                SizedBox(width: 20),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Icon(Trashure.facebook),
                                ),
                              ],
                            ),
                            SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Belum punya akun Trashue?'),
                                GestureDetector(
                                  child: Text(
                                    ' DAFTAR',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF416188),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterScreen()),
                                    );
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            _isLoading
                ? Stack(
                    children: <Widget>[
                      Opacity(
                        opacity: 0.3,
                        child: ModalBarrier(
                          dismissible: false,
                          color: Colors.grey,
                        ),
                      ),
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

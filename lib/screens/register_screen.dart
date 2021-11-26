import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashure_new/api/api_service.dart';
import 'package:trashure_new/misc/trashure_icons.dart';
import 'package:trashure_new/models/profile.dart';
import 'package:trashure_new/models/profile_provider.dart';
import 'package:trashure_new/screens/login_screen.dart';
import 'package:trashure_new/screens/main_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _noHPController = TextEditingController();
  final _passwordController = TextEditingController();
  ApiService _apiService = ApiService();
  bool _isLoading = false;

  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _nameController.dispose();
    _emailController.dispose();
    _noHPController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            print('back pressed');
          },
        ),
        title: Text('Daftar'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.maxFinite,
              height: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 90),
                      Column(
                        // Input Forms
                        children: [
                          TextFormField(
                            // Nama Input Form
                            controller: _nameController,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              hintText: 'Nama',
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(),
                            ),
                            textInputAction: TextInputAction.next,
                            // onFieldSubmitted: (v) {
                            //   FocusScope.of(context).nextFocus();
                            // },
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Name can't be empty";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 12),
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
                            // HP Input Form
                            controller: _noHPController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Nomor HP',
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(),
                            ),
                            textInputAction: TextInputAction.next,
                            // onFieldSubmitted: (v) {
                            //   FocusScope.of(context).nextFocus();
                            // },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Phone number can't be empty";
                              } else if (!(double.parse(value, (e) => null) !=
                                  null)) {
                                return 'Phone number must be number only';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 12),
                          TextFormField(
                            controller: _passwordController,
                            // Password Input Form
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
                      SizedBox(height: 30),
                      ElevatedButton(
                        child: Text('DAFTAR'),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            String name = _nameController.text;
                            String email = _emailController.text;
                            String noHP = _noHPController.text;
                            String password = _passwordController.text;

                            Profile profile = Profile(
                                name: name,
                                email: email,
                                no_hp: noHP,
                                password: password);
                            _apiService.register(profile).then((id) async {
                              setState(() => _isLoading = false);
                              if (id != null) {
                                print('success');
                                Profile data = await _apiService.getProfile(id);
                                var temp = Provider.of<ProfileProvider>(context,
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
                                  text: "Register failed, please try again!",
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
                            'atau daftar dengan',
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
                              Text('Sudah punya akun Trashue?'),
                              GestureDetector(
                                child: Text(
                                  ' MASUK',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF416188),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
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

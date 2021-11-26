import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trashure_new/api/api_service.dart';
import 'package:trashure_new/code/change_date.dart';
import 'package:trashure_new/components/header_with_icon.dart';
import 'package:trashure_new/constants.dart';
import 'package:trashure_new/models/profile.dart';
import 'package:trashure_new/models/profile_provider.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _noHPController = TextEditingController();

  final _ttlController = TextEditingController();

  DateTime _ttl;

  ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _nameController.text =
        Provider.of<ProfileProvider>(context, listen: false).name;
    _noHPController.text =
        Provider.of<ProfileProvider>(context, listen: false).noHP;
    _emailController.text =
        Provider.of<ProfileProvider>(context, listen: false).email;
    DateTime ttl = DateFormat("dd-MM-yyyy")
        .parse(Provider.of<ProfileProvider>(context, listen: false).ttl);
    _ttl = ttl;
    print(_ttl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 33),
                child: Form(
                  key: _formKey,
                  child: Consumer<ProfileProvider>(
                    builder: (context, cart, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 133),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    AssetImage('assets/images/ava.png'),
                              ),
                              Text(
                                'Edit Gambar',
                                style: kLightTextNotification.copyWith(
                                  color: Color(0xFF416188),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Divider(),
                          ),
                          Container(
                            width: double.maxFinite,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nama',
                                  textAlign: TextAlign.start,
                                  style: kGreyTextProfile,
                                ),
                                TextFormField(
                                  // Nama Input Form
                                  controller: _nameController,
                                  textCapitalization: TextCapitalization.words,
                                  textInputAction: TextInputAction.next,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "Name can't be empty";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: double.maxFinite,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nomor HP',
                                  textAlign: TextAlign.start,
                                  style: kGreyTextProfile,
                                ),
                                TextFormField(
                                  // HP Input Form
                                  controller: _noHPController,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Phone number can't be empty";
                                    } else if (!(double.parse(
                                            value, (e) => null) !=
                                        null)) {
                                      return 'Phone number must be number only';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: double.maxFinite,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email',
                                  textAlign: TextAlign.start,
                                  style: kGreyTextProfile,
                                ),
                                TextFormField(
                                  // Email Input Form
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
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
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: double.maxFinite,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tanggal Lahir',
                                  textAlign: TextAlign.start,
                                  style: kGreyTextProfile,
                                ),
                                DateTimeField(
                                  controller: _ttlController,
                                  format: DateFormat("dd-MM-yyyy"),
                                  onShowPicker: (context, currentValue) {
                                    return showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1900),
                                        initialDate: _ttl,
                                        lastDate: DateTime(2100));
                                  },
                                  validator: (val) {
                                    if (val != null) {
                                      return null;
                                    } else {
                                      return 'Date Field is Empty';
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 64),
                          ElevatedButton(
                            child: Text('UBAH'),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFFFF5722),
                            ),
                            onPressed: () {
                              // lanjutkan editnya.
                              setState(() {
                                _isLoading = true;
                              });
                              if (_formKey.currentState.validate()) {
                                Profile data = Profile(
                                  id: Provider.of<ProfileProvider>(context,
                                          listen: false)
                                      .id,
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  no_hp: _noHPController.text,
                                  ttl: changeDateToInt(_ttlController.text),
                                );
                                _apiService.update(data).then((status) async {
                                  if (status == 1) {
                                    Profile tmp =
                                        await _apiService.getProfile(data.id);
                                    var temp = Provider.of<ProfileProvider>(
                                        context,
                                        listen: false);
                                    temp.id = tmp.id;
                                    temp.name = tmp.name;
                                    temp.email = tmp.email;
                                    temp.noHP = tmp.no_hp;
                                    temp.setLevel(tmp.level);
                                    temp.balance = tmp.balance;
                                    temp.total = tmp.total;
                                    temp.setTTL(tmp.ttl * 1000);
                                    temp.avatar = tmp.avatar;
                                    temp.reload();
                                    Navigator.pop(context);
                                  } else {
                                    print('gagal');
                                  }
                                });
                              }
                              setState(() => _isLoading = false);
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
            HeaderWithIcon('Edit Akun'),
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

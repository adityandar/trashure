import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashure_new/api/api_service.dart';
import 'package:trashure_new/components/header_with_icon.dart';
import 'package:trashure_new/constants.dart';
import 'package:trashure_new/models/profile_provider.dart';

class PulsaScreen extends StatefulWidget {
  @override
  _PulsaScreenState createState() => _PulsaScreenState();
}

class _PulsaScreenState extends State<PulsaScreen> {
  TextEditingController _noHPController = TextEditingController();
  ApiService _apiService = ApiService();

  String valNominal;
  int valHarga;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  List<String> nominal = [
    "Rp 1000",
    "Rp 5000",
    "Rp 10000",
    "Rp 20000",
    "Rp 50000",
  ];

  List<int> harga = [
    1500,
    6000,
    11000,
    21000,
    51000,
  ];

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < nominal.length; i++) {
      if (valNominal == nominal[i]) {
        valHarga = harga[i];
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                HeaderWithIcon('Penukaran Pulsa'),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: double.maxFinite,
                      height: 350,
                      padding: EdgeInsets.all(32),
                      decoration: kCircularHomeContainer,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                } else if (!(double.parse(value, (e) => null) !=
                                    null)) {
                                  return 'Phone number must be number only';
                                } else if (value.length < 10) {
                                  return 'Minimum 9 numbers';
                                } else if (value.length > 14) {
                                  return 'Maximum 14 numbers';
                                }
                                return null;
                              },
                            ),
                            Text(
                              'Nominal',
                              textAlign: TextAlign.start,
                              style: kGreyTextProfile,
                            ),
                            DropdownButton(
                              isExpanded: true,
                              value: valNominal,
                              items: nominal.map((value) {
                                return DropdownMenuItem(
                                  child: Text(value),
                                  value: value,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  valNominal =
                                      value; //Untuk memberitahu _valFriends bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                                });
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Harga'),
                                Text(
                                  (valHarga != null) ? valHarga.toString() : "",
                                  style: TextStyle(fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                            SizedBox(height: 40),
                            ElevatedButton(
                              child: Text('Tukar'),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFFFF5722),
                              ),
                              onPressed: () {
                                setState(() {
                                  _isLoading = true;
                                });
                                if (_formKey.currentState.validate()) {
                                  var temp = Provider.of<ProfileProvider>(
                                      context,
                                      listen: false);

                                  setState(() => _isLoading = false);
                                  if (valHarga != null &&
                                      temp.balance > valHarga) {
                                    temp.balance -= valHarga;
                                    _apiService.pulsa(temp.id, temp.balance);
                                    CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.success,
                                      confirmBtnColor:
                                          Theme.of(context).primaryColor,
                                      text: "Transaction success!",
                                    );
                                  } else {
                                    CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.error,
                                      confirmBtnColor:
                                          Theme.of(context).primaryColor,
                                      text:
                                          "Transaction failed, please try again!",
                                    );
                                  }
                                }
                                setState(() => _isLoading = false);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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

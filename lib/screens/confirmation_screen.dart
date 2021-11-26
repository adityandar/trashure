import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashure_new/api/api_service.dart';
import 'package:trashure_new/models/profile_provider.dart';

class ConfirmationScreen extends StatefulWidget {
  ConfirmationScreen({this.code});

  final String code;

  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  final ApiService _apiService = ApiService();

  int success = 0;

  String idTrashbag;
  void checkID() async {
    final splitted = widget.code.split("=");
    print('masuk');
    final status = splitted[0] == "Trashure" && splitted[1].length >= 5;
    if (status) {
      print('cek server');
      var temp = await _apiService.connectTrashbag(splitted[1]);
      setState(() {
        if (temp) {
          success = 2;
        } else {
          success = 1;
        }
      });
      idTrashbag = splitted[1].toUpperCase();
      Provider.of<ProfileProvider>(context, listen: false).connectedTrashbag =
          idTrashbag;
      print(idTrashbag);
    } else {
      print('pulang');
      success = 1;
    }
  }

  @override
  void initState() {
    super.initState();
    checkID();
  }

  @override
  Widget build(BuildContext context) {
    if (success == 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                (success == 2)
                    ? Icons.check_circle
                    : Icons.error, //Icons.error for failed
                size: 84,
                color: (success == 2) ? Color(0xB38BC34A) : Color(0xB3FFA500),
              ),
              SizedBox(height: 28),
              Text(
                (success == 2) ? 'Berhasil' : 'Gagal',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 28),
              Text(
                (success == 2)
                    ? 'Trashbag telah tersambung'
                    : 'Trashbag gagal tersambung',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0x80000000),
                ),
              ),
              SizedBox(height: 12),
              Text(
                (success == 2) ? 'Trashbag ID #$idTrashbag' : '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0x80000000),
                ),
              ),
              SizedBox(height: 36),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 93),
                child: ElevatedButton(
                  child: Text('KEMBALI'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}

// Text((status) ? 'QR Terkonfirmasi' : 'QR Salah'),

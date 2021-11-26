import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trashure_new/constants.dart';
import 'package:trashure_new/misc/trashure_icons.dart';
import 'package:trashure_new/models/profile_provider.dart';
import 'package:trashure_new/screens/confirmation_screen.dart';

const flashOn = 'FLASH ON';
const flashOff = 'FLASH OFF';
const frontCamera = 'FRONT CAMERA';
const backCamera = 'BACK CAMERA';

class ScanScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  Barcode result;
  var flashState = flashOn;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final globalKey = GlobalKey<ScaffoldState>();
  String inputText = "";
  bool _connected = false;
  String _idTrashbag = "";

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  void initState() {
    super.initState();
    if (Provider.of<ProfileProvider>(context, listen: false)
            .connectedTrashbag !=
        null) {
      _connected = true;
      _idTrashbag = Provider.of<ProfileProvider>(context, listen: false)
          .connectedTrashbag;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      body: Stack(
        children: [
          SlidingUpPanel(
            minHeight: 84,
            maxHeight: 190,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            backdropColor: Colors.black,
            backdropEnabled: true,
            panel: Container(
              height: 190,
              width: double.maxFinite,
              child: Column(
                children: [
                  SizedBox(height: 14),
                  Column(
                    children: [
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                            bottom: Radius.circular(0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 28),
                  Text(
                    'atau masukkan kode ID Trashbag',
                    style: kGreyTextProfile,
                  ),
                  SizedBox(height: 28),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Masukkan ID',
                              prefixIcon: Icon(Icons.label),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (v) {
                              inputText = v;
                            },
                          ),
                          flex: 4,
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            child: Text('Input'),
                            onPressed: () {
                              var tmp = "Trashure=" + inputText;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ConfirmationScreen(code: tmp),
                                  ));
                              print('test');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            body: Stack(
              children: [
                Column(
                  children: <Widget>[
                    Container(
                      width: double.maxFinite,
                      height: MediaQuery.of(context).size.height,
                      child: _buildQrView(context),
                    )
                  ],
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 28),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            CircleButton(
                              icon: Icons.photo_library_outlined,
                              color: Colors.black,
                              onTap: () {
                                final snackBar = SnackBar(
                                    content: Text(
                                        'Feature is unavailable at this moment.'));
                                globalKey.currentState.showSnackBar(snackBar);
                              },
                            ),
                            SizedBox(width: 20),
                            CircleButton(
                              icon: (flashState == flashOff)
                                  ? Icons.flash_on
                                  : Icons.flash_off,
                              color: (flashState == flashOff)
                                  ? Colors.orange
                                  : Colors.black,
                              onTap: () {
                                if (controller != null) {
                                  controller.toggleFlash();
                                  if (_isFlashOn(flashState)) {
                                    setState(() {
                                      flashState = flashOff;
                                    });
                                  } else {
                                    setState(() {
                                      flashState = flashOn;
                                    });
                                  }
                                }
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          (_connected)
              ? Center(
                  child: Container(
                    width: 377,
                    height: 498,
                    decoration: kCircularHomeContainer,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Trashbag dengan ID $_idTrashbag\nmasih terhubung',
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
                              Provider.of<ProfileProvider>(context,
                                      listen: false)
                                  .connectedTrashbag = null;
                              setState(() {
                                _connected = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  bool _isFlashOn(String current) {
    return flashOn == current;
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return NotificationListener<SizeChangedLayoutNotification>(
        onNotification: (notification) {
          Future.microtask(
              () => controller?.updateDimensions(qrKey, scanArea: scanArea));
          return false;
        },
        child: SizeChangedLayoutNotifier(
            key: const Key('qr-size-notifier'),
            child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.red,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: scanArea,
                ))));
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      if (result != null) {
        if (controller != null) {
          if (_isFlashOn(flashState)) {
            setState(() {
              flashState = flashOn;
            });
          }
        }
        controller?.pauseCamera();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConfirmationScreen(code: result.code),
            ))
          ..then((value) => controller.resumeCamera());
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class CircleButton extends StatelessWidget {
  CircleButton({this.icon, this.color, this.onTap});

  final IconData icon;
  final Color color;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 40,
        height: 40,
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: new Icon(
          icon,
          color: color,
        ),
      ),
      onTap: onTap,
    );
  }
}

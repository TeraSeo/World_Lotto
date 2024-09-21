import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottery_kr/Home.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class QrCodePage extends StatefulWidget {
  const QrCodePage({super.key});

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    PermissionStatus status = await Permission.camera.status;
    if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
      status = await Permission.camera.request();
    }
    if (!status.isGranted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("camPermission".tr()),
        )
      );
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return 
      WillPopScope(
      onWillPop: () async {
        // Navigate to Home page when the user tries to leave the current page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
        return false;  // Returning false to handle the pop internally
      },
      child: Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 40),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, size: 28, color: Colors.black),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                ),
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.local_fire_department,
                        color: Colors.red,
                        size: 32,
                      ),
                      Text(
                      "qrCode".tr(),
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ]
                  )
                ),
              ],
            ),
          ),
          Expanded(flex: 4, child: _buildQrView(context)),
        ],
      ),
    ));
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      if (result != null) {
        _showConfirmationDialog();
      }
    });
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('loadPage'.tr()),
          content: Text('askLoadPage'.tr() + '\n${result!.code}?'),
          actions: <Widget>[
            TextButton(
              child: Text('no'.tr()),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => QrCodePage()),
                );
              },
            ),
            TextButton(
              child: Text('yes'.tr()),
              onPressed: () async {
                try {
                  final Uri url = Uri.parse(result!.code!);
                  await launchUrl(url);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => QrCodePage()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar( 
                    SnackBar(
                      content: Text('urlLoadFailed'.tr()),
                    )
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => QrCodePage()),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

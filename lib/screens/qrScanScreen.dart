import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:josm/screens/first_screen.dart';
// import 'package:josm/screens/first_screen.dart';
// import '../resources/auth_methods.dart';
// import '../utils/utils.dart';
// import '../widget/text_field_input.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class qrScanScreen extends StatefulWidget {
  const qrScanScreen({Key? key}) : super(key: key);
  @override
  State<qrScanScreen> createState() => _qrScanScreenState();
}

class _qrScanScreenState extends State<qrScanScreen> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController _controller;
  String qrCode = 'Unknown';

  // Request camera permission
  @override
  void initState() {
    super.initState();
    _controller = QRViewController(
      key: _qrKey,
      cameraFacing: CameraFacing.back,
    )..init(qrCodeCallback: (code) {
      setState(() {
        qrCode = code;
      });
    });
  }
  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello Employee'),
        actions: [
          IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: QRView(
              key: _qrKey,
              onQRViewCreated: (QRViewController controller) {
                this._controller = controller;
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                'Scan Result: $qrCode',
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Icon(
              Icons.info_outline,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
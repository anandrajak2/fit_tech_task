import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({super.key});

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  static const platform = MethodChannel('samples.flutter.dev/battery');
  String _Bluetooth_status = 'Please Wait';
  bool isEnable = false;
  Future<void> _enableBluetooth() async {
    String bluetoothStatus;
    try {
      final String result = await platform.invokeMethod('enableBluetooth');
      bluetoothStatus = result;
    } on PlatformException catch (e) {
      bluetoothStatus = " ${e.message}";
    }
    // _enableBluetooth();
    // if (bluetoothStatus == "Requesting Bluetooth permission...") {
    //   _enableBluetooth();
    // }
    setState(() {
      _Bluetooth_status = bluetoothStatus;
    });
  }

  Future<void> _toggleBluetooth() async {
    String bluetoothStatus;
    try {
      final bool result = await platform.invokeMethod('toggleBluetooth');
      setState(() {
        isEnable = result;
      });
      bluetoothStatus = result ? "Enabled" : "Disabled";
    } on PlatformException catch (e) {
      bluetoothStatus = " ${e.message}";
    }
    // _enableBluetooth();
    // if (bluetoothStatus == "Requesting Bluetooth permission...") {
    //   _enableBluetooth();
    // }
    setState(() {
      _Bluetooth_status = bluetoothStatus;
    });
  }

  Future<void> _checkPermission() async {
    String bluetoothStatus;
    try {
      final bool result = await platform.invokeMethod('checkPermission');
      bluetoothStatus = "Permission Grant";
    } on PlatformException catch (e) {
      bluetoothStatus = " ${e.message}";
    }
    print(bluetoothStatus);
    // _enableBluetooth();
    // if (bluetoothStatus == "Requesting Bluetooth permission...") {
    //   _enableBluetooth();
    // }
    setState(() {
      _Bluetooth_status = bluetoothStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    _checkPermission();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Bluetooth Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: isEnable ? Colors.green : Colors.grey[400],
                    foregroundColor: Colors.white),
                onPressed: _toggleBluetooth,
                child: Text('${isEnable ? "Disable" : "Enable"} Bluetooth'),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // Text(
            //   _Bluetooth_status,
            // ),
          ],
        ),
      ),
    );
  }
}

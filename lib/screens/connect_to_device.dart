import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:pain_drain_mobile_app/scheme_colors/app_colors.dart';
import 'package:pain_drain_mobile_app/controllers/bluetooth_controller.dart';
import '../helper_files/clip_paths.dart';
import '../custom_widgets/bluetooth_icon_animation.dart';
import '../custom_widgets/check_mark_animation.dart';
import '../custom_widgets/x_mark_animation.dart';
import 'home_screen.dart';

class ConnectDevice extends StatefulWidget {
  const ConnectDevice({Key? key}) : super(key: key);

  @override
  State<ConnectDevice> createState() => _ConnectDeviceState();
}

class _ConnectDeviceState extends State<ConnectDevice> with SingleTickerProviderStateMixin {
  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;

  late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;
  late AnimationController _animationController;
  late Animation<double> _animation;
  final BluetoothController _bleController = Get.find<BluetoothController>();

  bool showCheckMark = false;
  bool showXMark =  false;
  bool isPulsing = false;

  @override
  @override
  void initState() {
    super.initState();
    _adapterStateStateSubscription = FlutterBluePlus.adapterState.listen((state) {
      _adapterState = state;
    });
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOutCirc
        )
    );
  }

  @override
  void dispose() {
    _adapterStateStateSubscription.cancel();
    super.dispose();
  }


  Future<void> scanAndConnect() async {
    String errorMessage;
    String solution;
    setState(() {
      isPulsing = true;
    });

    if(_adapterState == BluetoothAdapterState.on){
      await _bleController.scanForDevices();
      List<ScanResult> results = _bleController.scanResults;
      if(results.isNotEmpty){
        BluetoothDevice device = results.first.device;
        bool success = await _bleController.connectDevice(device);
        if(success) {
          setState(() {
            isPulsing = false;
            showCheckMark = true;
            _animationController.forward();
          });
          await Future.delayed(const Duration(seconds: 2));
          Get.off(() => const HomeScreen());
          print("success");
        }
        else {
          errorMessage = "Connection Failed";
          solution = "Please try again";
          setState(() {
            isPulsing = false;
            showXMark = true;
            _animationController.forward();
          });

          await Future.delayed(const Duration(seconds: 2));

          setState(() {
            showXMark = false;
            _animationController.reset();
          });
          print("Unsuccessful Connection: Could not connect to PainDrain device");
          _showDialog(errorMessage, solution);
        }
      }
      else {
        errorMessage = "Could not find device";
        solution = "Make sure device is on and awake and then try again";
        setState(() {
          isPulsing = false;
          showXMark = true;
          _animationController.forward();
        });
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          showXMark = false;
          _animationController.reset();

        });
        print("Unsuccessful Scan: No results for PainDrain found");
        _showDialog(errorMessage, solution);
      }
      print("List ${_bleController.scanResults}");
    } else{
      errorMessage = "Bluetooth not enabled";
      solution = "Please make sure to enable bluetooth on your device";
      _showDialog(errorMessage, solution);

      setState(() {
        isPulsing = false;
      });
      if (Platform.isAndroid) {
        await FlutterBluePlus.turnOn();
      }
    }
  }

  void _showDialog(String errorMessage, String solution){
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(errorMessage),
            content: Text(solution),
            actions: [
              MaterialButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Ok"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 200, // Adjust the value as needed
            left: (MediaQuery.of(context).size.width - 180) / 2, // Adjust the value as needed
            child: SizedBox(
              width: 180,
              height: 180,
              child: Center(
                child: showCheckMark
                    ? SuccessfulConnection(animation: _animation)
                    : (showXMark
                    ? UnsuccessfulConnection(animation: _animation)
                    : PulseIcon(isPulsing: isPulsing)),
              ),
            ),
          ),
          //ElevatedButton(onPressed: _showDialog, child: Text("Test")),

          Align(
            alignment: Alignment.bottomCenter,
              child: CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 270),
                painter: CurvePainter(color: Colors.lightBlue),
              )
            // child:
            //
            // ClipPath(
            //   clipper: ConnectBottomScreenClipper(),
            //   child: Container(
            //     color: Colors.lightBlue, //AppColors.amber.withOpacity(.7),
            //     height: 525,
            //     width: MediaQuery.of(context).size.width,
            //   ),
            // ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 250),
              painter: CurvePainter(color: Colors.blue.shade700),
            )
            // ClipPath(
            //   clipper: ConnectBottomScreenClipper(),
            //   child: Container(
            //     color: Colors.blue.shade700,
            //     height: 500,
            //     width: MediaQuery.of(context).size.width,
            //   ),
            // ),
          ),
          Positioned(
            bottom: 30,
            // left: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    const Text("Press 'CONNECT' to connect", style: TextStyle(color: AppColors.offWhite, fontSize: 20),),
                    const SizedBox(height: 3,),
                    const Text("to Pain Drain device", style: TextStyle(color: AppColors.offWhite, fontSize: 20),),
                    const SizedBox(height: 30,),
                    SizedBox(
                      width: 200,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () async {
                          if(!isPulsing){
                            await scanAndConnect();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: const Text(
                          'CONNECT',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  final Color color;

  CurvePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    double leftXPoint = size.width * .2;
    double leftYPoint = size.height * .3;
    double rightXPoint = size.width - (size.width * .2);
    double rightYPoint = size.height * -.3;
    double centerXPoint = size.width / 2;
    var paint = Paint()..color = color;

    var path = Path()
      ..moveTo(0, 0) // Top left point of the container
      ..quadraticBezierTo(leftXPoint, leftYPoint, centerXPoint, 0)
      ..quadraticBezierTo(rightXPoint, rightYPoint, size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
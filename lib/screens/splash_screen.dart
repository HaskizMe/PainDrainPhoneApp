import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pain_drain_mobile_app/screens/connect_to_device.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  // Store the context when the widget is created
  late BuildContext storedContext;

  @override
  void initState() {
    super.initState();

    // Gets rid of top and bottom bars on the phone
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // Store the context for later use
    storedContext = context;

    // Shows the splash screen for 5 seconds and points to the ConnectDevice screen
    Future.delayed(const Duration(seconds: 5), () {
      // Check if the widget is still mounted before navigating
      if (mounted) {
        Navigator.of(storedContext).pushReplacement(MaterialPageRoute(
          builder: (_) => const ConnectDevice(),
        ));
      }
    });
  }

  @override
  void dispose() {
    // Brings back top and bottom bars on the phone
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.black54],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite,
              size: 80,
              color: Colors.white60,
            ),
            SizedBox(height: 20),
            Text(
              'Pain Drain',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.white60,
                fontSize: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


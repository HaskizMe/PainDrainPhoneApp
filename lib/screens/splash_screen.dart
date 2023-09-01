import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pain_drain_mobile_app/scheme_colors/app_colors.dart';
import 'package:pain_drain_mobile_app/screens/connect_to_device.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    // Gets rid top and bottom bar on phone
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // Shows splash screen for 5 seconds and points to the PageNavigation method
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => const ConnectDevice()
        ),
      );
    });
  }

  @override
  void dispose() {
    // Brings back top and bottom bar on phone
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
              colors: [AppColors.yellow, AppColors.orangeRed],
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

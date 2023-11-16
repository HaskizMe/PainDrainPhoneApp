import 'package:flutter/material.dart';
import 'package:pain_drain_mobile_app/scheme_colors/app_colors.dart';
import 'package:pain_drain_mobile_app/screens/ble_scan.dart';

import '../main.dart';
import '../widgets/custom_card.dart';

class ConnectDevice extends StatelessWidget {
  const ConnectDevice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGrey,
      body: Center(
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              //mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    'assets/PainDrainDeviceWithoutBackground.png',
                    width: MediaQuery.of(context).size.width * 0.65,
                    height: MediaQuery.of(context).size.height * 0.30,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Connect to Device',
                  style: TextStyle(
                    color: AppColors.offWhite,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: 200,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const BleConnect()),
                         // MaterialPageRoute(builder: (context) => PageNavigation(activePage: 0, pageController: PageController(initialPage: 0),))
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.darkerGrey,
                    ),
                    child: const Text(
                        'CONNECT',
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



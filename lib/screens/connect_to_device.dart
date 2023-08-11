import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pain_drain_mobile_app/main.dart';
import 'package:pain_drain_mobile_app/scheme_colors/app_colors.dart';

class ConnectDevice extends StatelessWidget {
  const ConnectDevice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.yellow,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.80,
          height: MediaQuery.of(context).size.height * 0.5,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.orangeRed,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  'assets/PainDrainDeviceWithoutBackground.png',
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: MediaQuery.of(context).size.height * 0.30,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Connect to Device',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PageNavigation()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.navyBlue,
                ),
                child: const Text('CONNECT'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



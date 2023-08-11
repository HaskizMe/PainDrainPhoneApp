import 'package:flutter/material.dart';
import 'screens/TENS_settings.dart';
import 'screens/temp_settings.dart';
import 'screens//vibration_settings.dart';
import 'screens/preset_settings.dart';
import 'screens/splash_screen.dart';
import 'screens/connect_to_device.dart';


// Main function that is where app starts to run
void main() {
  runApp(const MaterialApp(
    home: SplashScreen(),
  ));
}

// This class Navigates through all the screens
class PageNavigation extends StatefulWidget {
  const PageNavigation({Key? key}) : super(key: key);

  @override
  State<PageNavigation> createState() => _PageNavigation();
}

class _PageNavigation extends State<PageNavigation> {
  // Declare and initialize the page controller
  final PageController _pageController = PageController(initialPage: 0);

  // The index of the current page
  int _activePage = 0;

  final List<Widget> _pages = [
    //const ConnectDevice(),
    const TENSSettings(),
    const TempSettings(),
    const VibrationSettings(),
    const PresetSettings()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page){
              setState(() {
                _activePage = page;
              });
            },
            itemCount: _pages.length,
            itemBuilder: (BuildContext context, int index) {
              return _pages[index % _pages.length];
            },
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 80,
            child: Container(
              color: Colors.black54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                  _pages.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: InkWell(
                        onTap: () {
                          _pageController.animateToPage(index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: _activePage == index
                            ? Colors.amber : Colors.grey,
                        ),
                      ),
                    )
                )
              )
            ),
          ),

        ],
      ),
    );
  }
}







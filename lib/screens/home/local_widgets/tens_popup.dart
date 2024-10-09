import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pain_drain_mobile_app/models/bluetooth.dart';
import 'package:pain_drain_mobile_app/widgets/vertical_slider.dart';
import 'package:pain_drain_mobile_app/widgets/horizontal_slider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

import '../../../models/stimulus.dart';
import '../../../utils/app_colors.dart';

class TensPopup extends StatefulWidget {
  const TensPopup({Key? key}) : super(key: key);

  @override
  State<TensPopup> createState() => _TensPopupState();
}

class _TensPopupState extends State<TensPopup> with TickerProviderStateMixin{
  final Stimulus _stimController = Get.find();
  late AnimationController controller1;
  late AnimationController controller2;

  late Animation<double> animation1;
  late Animation<double> animation2;


  late bool _isOn;
  int selectedIndex = 0;
  late int _mode;
  late int playButtonChannel1;
  late int playButtonChannel2;

  final Bluetooth _bleController = Get.find();
  //int tabIndex = 0;
  bool isPlayingChannel1 = false;
  bool isPlayingChannel2 = false;
  bool animationComplete = false;

  @override
  void initState() {
    super.initState();
    _isOn = _stimController.isPhaseOn(); // Assign the value of _stimController.isPhaseOn() to _isOn
    if(_isOn){
      selectedIndex = 1;
    } else {
      selectedIndex = 0;
    }
    controller1 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation1 = Tween<double>(begin: 0.0, end: 1.0).animate(controller1);
    controller2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    animation2 = Tween<double>(begin: 0.0, end: 1.0).animate(controller2);

    playButtonChannel1 = _stimController.getStimulus(_stimController.tensPlayButtonChannel1).toInt();
    playButtonChannel2 = _stimController.getStimulus(_stimController.tensPlayButtonChannel2).toInt();
    if(playButtonChannel1 == 1){
      isPlayingChannel1 = true;
      controller1.forward();
    }
    if(playButtonChannel2 == 1){
      isPlayingChannel2 = true;
      controller2.forward();
    }
  }

  @override
  void dispose(){
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }
  // late bool _isOn;
  String stimulus = "tens";
  //bool _isOn = _stimController.isPhaseOn();


  @override
  Widget build(BuildContext context) {
    String amp = _stimController.tensIntensity;
    String period = _stimController.tensPeriod;
    String ch1 = _stimController.tensDurCh1;
    String ch2 = _stimController.tensDurCh2;
    String tensPhase = _stimController.tensPhase;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
      child: Obx(() {
        _bleController.isCharging.value;
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Grey horizontal line and Tens title
            Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  width: 150,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.4),
                      borderRadius: BorderRadius.circular(5.0)
                  ),
                ),
                const SizedBox(height: 20),
                const Text("TENS", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                //const SizedBox(height: 10),
              ],
            ),

            // Intensity Slider
            Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: CustomHorizontalSlider(title: "", currentValue: _stimController.getStimulus(amp), stimulusType: amp, stimulus: stimulus)
            ),

            // Phase switch
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Phase:', style: TextStyle(fontSize: 18),),
                const SizedBox(width: 5,),
                FlutterToggleTab(
                  width: 30,
                  height: 40,
                  labels: const ['0', '180'],
                  selectedTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                  ),
                  unSelectedTextStyle: const TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                      fontWeight: FontWeight.w400
                  ),
                  selectedBackgroundColors: const [Colors.blue],
                  selectedIndex: selectedIndex,
                  selectedLabelIndex:(index) async {
                    setState(() {
                      if(selectedIndex == 1){
                        selectedIndex = 0;
                        _stimController.setStimulus(_stimController.tensPhase, 0);
                      } else{
                        selectedIndex = 1;
                        _stimController.setStimulus(_stimController.tensPhase, 180);
                      }
                    });
                    String command = _bleController.getCommand("tens");
                    await _bleController.newWriteToDevice(command);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Container(
              //width: 2,
              height: 2,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(15)
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  //Channel 1
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      // Title
                      const Text("Channel 1", style: TextStyle(fontSize: 18),),

                        // Mode selector
                      FlutterToggleTab(
                        width: 35,
                        height: 28,
                        borderRadius: 15,
                        selectedTextStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                        ),
                        unSelectedTextStyle: const TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                            fontWeight: FontWeight.w400
                        ),
                        selectedBackgroundColors: const [Colors.blue],
                        labels: const ["Mode 1", "Mode 2"],
                        marginSelected: const EdgeInsets.fromLTRB(2.0, 2.0, 0.0, 2.0),
                        selectedIndex: _stimController.getStimulus(_stimController.tensModeChannel1).toInt() - 1, // -1 to make number an index
                        selectedLabelIndex: (index) async {
                          setState(() {
                            // Sets the mode for channel 1
                            _stimController.setStimulus(_stimController.tensModeChannel1, index + 1); // +1 to index to make it a number. index 1 means mode 2
                            // Sets the current channel to channel 1
                            _stimController.setStimulus(_stimController.currentChannel, 1);
                          });
                          String command = _bleController.getCommand("tens");
                          await _bleController.newWriteToDevice(command);
                        },
                      ),


                      // Play Pause Button
                      Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20.0)
                          //shape: BoxShape.circle, // Make the container circular
                        ),
                        child: IconButton(
                          onPressed: () {
                            if (controller1.isCompleted || controller1.isDismissed) {
                              print("Animation done");
                              isPlayingChannel1 = !isPlayingChannel1;
                              if (isPlayingChannel1) {
                                _stimController.setStimulus(_stimController.tensPlayButtonChannel1, 1); // 1 means its playing
                                controller1.forward();
                              } else {
                                _stimController.setStimulus(_stimController.tensPlayButtonChannel1, 0); // 0 means its paused
                                controller1.reverse();
                              }
                              // Setting current channel to channel 1
                              setState(() => _stimController.setStimulus(_stimController.currentChannel, 1));
                              String command = _bleController.getCommand("tens");
                              _bleController.newWriteToDevice(command);
                            }
                          },
                          icon: AnimatedIcon(
                            icon: AnimatedIcons.play_pause,
                            progress: animation1,
                            color: Colors.white,
                            size: 25,
                            //size: 50,// Icon color
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Grey line separator
                  Container(
                    width: 2,
                    //height: 100,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(15)
                    ),
                  ),

                  // Channel 2
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      // Title
                      const Text("Channel 2", style: TextStyle(fontSize: 18),),

                      // Mode selector for channel 2
                      FlutterToggleTab(
                        width: 35,
                        height: 28,
                        borderRadius: 15,
                        selectedTextStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                        ),
                        unSelectedTextStyle: const TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                            fontWeight: FontWeight.w400
                        ),
                        selectedBackgroundColors: const [Colors.blue],
                        labels: const ["Mode 1", "Mode 2"],
                        marginSelected: const EdgeInsets.fromLTRB(2.0, 2.0, 0.0, 2.0),
                        selectedIndex: _stimController.getStimulus(_stimController.tensModeChannel2).toInt() - 1, // -1 to make number an index
                        selectedLabelIndex: (index) {
                          setState(() {
                            // Sets the mode for channel 2
                            _stimController.setStimulus(_stimController.tensModeChannel2, index + 1); // +1 to index to make it a number. index 0 means mode 1
                            // Sets the current channel to channel 2
                            _stimController.setStimulus(_stimController.currentChannel, 2);
                          });
                          String command = _bleController.getCommand("tens");
                          _bleController.newWriteToDevice(command);
                        },
                      ),

                      // Play Pause Button for channel 2
                      Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20.0)
                          //shape: BoxShape.circle, // Make the container circular
                        ),
                        child: IconButton(
                          onPressed: () {
                            if (controller1.isCompleted || controller1.isDismissed) {
                              print("Animation done");
                              isPlayingChannel2 = !isPlayingChannel2;
                              if (isPlayingChannel2) {
                                controller2.forward();
                                _stimController.setStimulus(_stimController.tensPlayButtonChannel2, 1); // 1 means its playing
                              } else {
                                _stimController.setStimulus(_stimController.tensPlayButtonChannel2, 0); // 0 means its paused
                                controller2.reverse();
                              }
                              // Sets the current channel to channel 2
                              setState(() => _stimController.setStimulus(_stimController.currentChannel, 2));
                              String command = _bleController.getCommand("tens");
                              _bleController.newWriteToDevice(command);
                            }
                          },
                          icon: AnimatedIcon(
                            icon: AnimatedIcons.play_pause,
                            progress: animation2,
                            color: Colors.white,
                            size: 25,
                            //size: 50,// Icon color
                          ),
                        ),
                      ),
                    ],
                  ),
                  //CustomHorizontalSlider(title: title, currentValue: currentValue, stimulusType: stimulusType, stimulus: stimulus)
                  // CustomHorizontalSlider(title: "Intensity", currentValue: _stimController.getStimulus(amp), stimulusType: amp, stimulus: stimulus),
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     // Container(
                  //     //   width: 180,
                  //     //   height: 2,
                  //     //   decoration: BoxDecoration(
                  //     //       color: Colors.grey.shade300,
                  //     //       borderRadius: BorderRadius.circular(15)
                  //     //   ),
                  //     // ),
                  //     //Channel 1
                  //
                  //     Column(
                  //       children: [
                  //
                  //         // Title
                  //         Text("Channel 1", style: TextStyle(fontSize: 18),),
                  //
                  //         const SizedBox(height: 10,),
                  //
                  //         // Mode selector
                  //         FlutterToggleTab(
                  //           width: 45,
                  //           height: 25,
                  //           borderRadius: 15,
                  //           selectedTextStyle: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 16,
                  //               fontWeight: FontWeight.w600
                  //           ),
                  //           unSelectedTextStyle: TextStyle(
                  //               color: Colors.blue,
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.w400
                  //           ),
                  //           selectedBackgroundColors: [Colors.blue],
                  //           labels: ["Mode 1", "Mode 2"],
                  //           marginSelected: EdgeInsets.fromLTRB(2.0, 2.0, 0.0, 2.0),
                  //           //icons: _listIconTabToggle,
                  //           selectedIndex: _stimController.getStimulus(_stimController.tensMode).toInt() - 1,
                  //           selectedLabelIndex: (index) {
                  //             setState(() {
                  //               //_mode = index;
                  //               _stimController.setStimulus(_stimController.tensMode, index + 1);
                  //               //_stimController.setCurrentMode(index + 1); // So that index 0 is mode 1 and index 1 is mode 2
                  //             });
                  //           },
                  //         ),
                  //
                  //         const SizedBox(height: 10,),
                  //
                  //         // Play Pause Button
                  //         Container(
                  //           width: 70,
                  //           //height: 30,
                  //           decoration: BoxDecoration(
                  //             color: Colors.blue,
                  //             //borderRadius: BorderRadius.circular(20.0)
                  //             shape: BoxShape.circle, // Make the container circular
                  //           ),
                  //           child: IconButton(
                  //             onPressed: () {
                  //               if (controller.isCompleted || controller.isDismissed) {
                  //                 print("Animation done");
                  //                 isPlaying = !isPlaying;
                  //                 if (isPlaying) {
                  //                   controller.forward();
                  //                 } else {
                  //                   controller.reverse();
                  //                 }
                  //               }
                  //             },
                  //             icon: AnimatedIcon(
                  //               icon: AnimatedIcons.play_pause,
                  //               progress: animation,
                  //               color: Colors.white,
                  //               size: 25,
                  //               //size: 50,// Icon color
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //
                  //     // Grey spacer container
                  //     // Container(
                  //     //   width: 180,
                  //     //   height: 2,
                  //     //   decoration: BoxDecoration(
                  //     //       color: Colors.grey.shade300,
                  //     //       borderRadius: BorderRadius.circular(15)
                  //     //   ),
                  //     // ),
                  //
                  //     // Channel 2
                  //     Column(
                  //       children: [
                  //         // Title
                  //         Text("Channel 2", style: TextStyle(fontSize: 18),),
                  //
                  //         const SizedBox(height: 10,),
                  //
                  //         // Mode selector
                  //         FlutterToggleTab(
                  //           width: 45,
                  //           height: 25,
                  //           borderRadius: 15,
                  //           selectedTextStyle: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 16,
                  //               fontWeight: FontWeight.w600
                  //           ),
                  //           unSelectedTextStyle: TextStyle(
                  //               color: Colors.blue,
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.w400
                  //           ),
                  //           selectedBackgroundColors: [Colors.blue],
                  //           labels: ["Mode 1", "Mode 2"],
                  //           marginSelected: EdgeInsets.fromLTRB(2.0, 2.0, 0.0, 2.0),
                  //           //icons: _listIconTabToggle,
                  //           selectedIndex: _stimController.getStimulus(_stimController.tensMode).toInt() - 1,
                  //           selectedLabelIndex: (index) {
                  //             setState(() {
                  //               //_mode = index;
                  //               _stimController.setStimulus(_stimController.tensMode, index + 1);
                  //               //_stimController.setCurrentMode(index + 1); // So that index 0 is mode 1 and index 1 is mode 2
                  //             });
                  //           },
                  //         ),
                  //
                  //         const SizedBox(height: 10,),
                  //
                  //         // Play pause button
                  //         Container(
                  //           width: 70,
                  //           //height: 30,
                  //           decoration: BoxDecoration(
                  //               color: Colors.blue,
                  //               //borderRadius: BorderRadius.circular(20.0),
                  //             shape: BoxShape.circle, // Make the container circular
                  //           ),
                  //           child: IconButton(
                  //             onPressed: () {
                  //               if (controller.isCompleted || controller.isDismissed) {
                  //                 print("Animation done");
                  //                 isPlaying = !isPlaying;
                  //                 if (isPlaying) {
                  //                   controller.forward();
                  //                 } else {
                  //                   controller.reverse();
                  //                 }
                  //               }
                  //             },
                  //             icon: AnimatedIcon(
                  //               icon: AnimatedIcons.play_pause,
                  //               progress: animation,
                  //               color: Colors.white,
                  //               size: 25,
                  //               //size: 50,// Icon color
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     // Container(
                  //     //   width: 180,
                  //     //   height: 2,
                  //     //   decoration: BoxDecoration(
                  //     //       color: Colors.grey.shade300,
                  //     //       borderRadius: BorderRadius.circular(15)
                  //     //   ),
                  //     // ),
                  //     // //Channel 1
                  //     // Text("Channel 1"),
                  //     // FlutterToggleTab(
                  //     //   width: 40,
                  //     //   height: 40,
                  //     //   borderRadius: 15,
                  //     //   selectedTextStyle: TextStyle(
                  //     //       color: Colors.white,
                  //     //       fontSize: 16,
                  //     //       fontWeight: FontWeight.w600
                  //     //   ),
                  //     //   unSelectedTextStyle: TextStyle(
                  //     //       color: Colors.blue,
                  //     //       fontSize: 14,
                  //     //       fontWeight: FontWeight.w400
                  //     //   ),
                  //     //   selectedBackgroundColors: [Colors.blue],
                  //     //   labels: ["Mode 1", "Mode 2"],
                  //     //   marginSelected: EdgeInsets.fromLTRB(2.0, 2.0, 0.0, 2.0),
                  //     //   //icons: _listIconTabToggle,
                  //     //   selectedIndex: _stimController.getStimulus(_stimController.tensMode).toInt() - 1,
                  //     //   selectedLabelIndex: (index) {
                  //     //     setState(() {
                  //     //       //_mode = index;
                  //     //       _stimController.setStimulus(_stimController.tensMode, index + 1);
                  //     //       //_stimController.setCurrentMode(index + 1); // So that index 0 is mode 1 and index 1 is mode 2
                  //     //     });
                  //     //   },
                  //     // ),
                  //     // const SizedBox(height: 20,),
                  //     // SizedBox(
                  //     //   width: 80,
                  //     //   height: 40,
                  //     //   child: ElevatedButton(
                  //     //     onPressed: () {
                  //     //       if (controller.isCompleted || controller.isDismissed) {
                  //     //         print("Animation done yay");
                  //     //         isPlaying = !isPlaying;
                  //     //         if (isPlaying) {
                  //     //           controller.forward();
                  //     //         } else {
                  //     //           controller.reverse();
                  //     //         }
                  //     //       }
                  //     //     },
                  //     //     style: ElevatedButton.styleFrom(
                  //     //         backgroundColor: Colors.blue
                  //     //     ),
                  //     //     child: AnimatedIcon(icon: AnimatedIcons.play_pause, progress: animation, color: Colors.white, size: 35,),
                  //     //   ),
                  //     // ),
                  //     // const SizedBox(height: 20,),
                  //     // Container(
                  //     //   width: 180,
                  //     //   height: 2,
                  //     //   decoration: BoxDecoration(
                  //     //     color: Colors.grey.shade300,
                  //     //     borderRadius: BorderRadius.circular(15)
                  //     //   ),
                  //     // ),
                  //     //
                  //     // // Channel 2
                  //     // const SizedBox(height: 20,),
                  //     // Text("Channel 2", style: TextStyle(fontSize: 18),),
                  //     // const SizedBox(height: 25,),
                  //     // FlutterToggleTab(
                  //     //   width: 45,
                  //     //   height: 25,
                  //     //   borderRadius: 15,
                  //     //   selectedTextStyle: TextStyle(
                  //     //       color: Colors.white,
                  //     //       fontSize: 16,
                  //     //       fontWeight: FontWeight.w600
                  //     //   ),
                  //     //   unSelectedTextStyle: TextStyle(
                  //     //       color: Colors.blue,
                  //     //       fontSize: 14,
                  //     //       fontWeight: FontWeight.w400
                  //     //   ),
                  //     //   selectedBackgroundColors: [Colors.blue],
                  //     //   labels: ["Mode 1", "Mode 2"],
                  //     //   marginSelected: EdgeInsets.fromLTRB(2.0, 2.0, 0.0, 2.0),
                  //     //   //icons: _listIconTabToggle,
                  //     //   selectedIndex: _stimController.getStimulus(_stimController.tensMode).toInt() - 1,
                  //     //   selectedLabelIndex: (index) {
                  //     //     setState(() {
                  //     //       //_mode = index;
                  //     //       _stimController.setStimulus(_stimController.tensMode, index + 1);
                  //     //       //_stimController.setCurrentMode(index + 1); // So that index 0 is mode 1 and index 1 is mode 2
                  //     //     });
                  //     //   },
                  //     // ),
                  //     // const SizedBox(height: 30,),
                  //     // SizedBox(
                  //     //   width: 80,
                  //     //   height: 40,
                  //     //   child: ElevatedButton(
                  //     //     onPressed: () {
                  //     //       if (controller.isCompleted || controller.isDismissed) {
                  //     //         print("Animation done yay");
                  //     //         isPlaying = !isPlaying;
                  //     //         if (isPlaying) {
                  //     //           controller.forward();
                  //     //         } else {
                  //     //           controller.reverse();
                  //     //         }
                  //     //       }
                  //     //     },
                  //     //     style: ElevatedButton.styleFrom(
                  //     //         backgroundColor: Colors.blue
                  //     //     ),
                  //     //     child: AnimatedIcon(icon: AnimatedIcons.play_pause, progress: animation, color: Colors.white, size: 35,),
                  //     //   ),
                  //     // ),
                  //     // const SizedBox(height: 20,),
                  //   ],
                  // )
                ],
              ),
            )
            // const SizedBox(height: 20),
            // Container(
            //   width: 150,
            //   height: 10,
            //   decoration: BoxDecoration(
            //       color: Colors.grey.withOpacity(.4),
            //       borderRadius: BorderRadius.circular(5.0)
            //   ),
            // ),
            // const SizedBox(height: 20),
            // const Text("TENS", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            // const SizedBox(height: 10),
            // Padding(
            //   padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
            //   child: Column(
            //     children: [
            //       FlutterToggleTab(
            //         width: 40,
            //         height: 40,
            //         borderRadius: 15,
            //         selectedTextStyle: TextStyle(
            //             color: Colors.white,
            //             fontSize: 16,
            //             fontWeight: FontWeight.w600
            //         ),
            //         unSelectedTextStyle: TextStyle(
            //             color: Colors.blue,
            //             fontSize: 14,
            //             fontWeight: FontWeight.w400
            //         ),
            //         selectedBackgroundColors: [Colors.blue],
            //         labels: ["Mode 1", "Mode 2"],
            //         marginSelected: EdgeInsets.fromLTRB(2.0, 2.0, 0.0, 2.0),
            //         //icons: _listIconTabToggle,
            //         selectedIndex: _stimController.getStimulus(_stimController.tensMode).toInt() - 1,
            //         selectedLabelIndex: (index) {
            //           setState(() {
            //             //_mode = index;
            //             _stimController.setStimulus(_stimController.tensMode, index + 1);
            //             //_stimController.setCurrentMode(index + 1); // So that index 0 is mode 1 and index 1 is mode 2
            //           });
            //         },
            //       ),
            //       const SizedBox(height: 70,),
            //       CustomHorizontalSlider(
            //         title: 'Intensity\n',
            //         //title: "",
            //         currentValue: _stimController.getStimulus(amp),
            //         stimulusType: amp,
            //         stimulus: stimulus,
            //       ),
            //     ],
            //   ),
            // ),
            // Column(
            //   children: [
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         const SizedBox(height: 30,),
            //         SizedBox(
            //           width: 80,
            //           height: 40,
            //           child: ElevatedButton(
            //             onPressed: () {
            //               if (controller.isCompleted || controller.isDismissed) {
            //                 print("Animation done yay");
            //                 isPlaying = !isPlaying;
            //                 if (isPlaying) {
            //                   controller.forward();
            //                 } else {
            //                   controller.reverse();
            //                 }
            //               }
            //             },
            //             style: ElevatedButton.styleFrom(
            //                 backgroundColor: Colors.blue
            //             ),
            //             child: AnimatedIcon(icon: AnimatedIcons.play_pause, progress: animation, color: Colors.white, size: 35,),
            //           ),
            //         )
            //       ],
            //     ),
            //   ],
            // )
            // Expanded(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       CustomVerticalSlider(
            //         title: 'Intensity\n',
            //         currentValue: _stimController.getStimulus(amp),
            //         stimulusType: amp,
            //         stimulus: stimulus,
            //       ),
            //       CustomVerticalSlider(
            //         title: 'Period\n',
            //         currentValue: _stimController.getStimulus(period),
            //         stimulusType: period,
            //         stimulus: stimulus,
            //       ),
            //       CustomVerticalSlider(
            //         title: ' Duration\nChannel 1',
            //         minValue: 0.0,
            //         maxValue: 1.0,
            //         isDecimal: true,
            //         measurementType: "s",
            //         currentValue: _stimController.getStimulus(ch1),
            //         stimulusType: ch1,
            //         stimulus: stimulus,
            //         channel: 1,
            //       ),
            //       CustomVerticalSlider(
            //         title: ' Duration\nChannel 2',
            //         minValue: 0.0,
            //         maxValue: 1.0,
            //         isDecimal: true,
            //         measurementType: "s",
            //         currentValue: _stimController.getStimulus(ch2),
            //         stimulusType: ch2,
            //         stimulus: stimulus,
            //         channel: 2,
            //       ),
            //     ],
            //   ),
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //
            //     const Text("0"),
            //     const SizedBox(width: 5.0),
            //     Switch(
            //       activeColor: Colors.blue,
            //       value: _stimController.isPhaseOn(),
            //       onChanged: (bool value) async {
            //         if(!_bleController.isCharging.value){
            //           setState(() {
            //             _isOn = value;
            //           });
            //           if (value) {
            //             _stimController.setStimulus(tensPhase, 180.0);
            //           } else {
            //             _stimController.setStimulus(tensPhase, 0.0);
            //           }
            //           String command = _bleController.getCommand("phase");
            //           await _bleController.newWriteToDevice(command);
            //         }
            //       },
            //     ),
            //     const SizedBox(width: 5.0),
            //     const Text("180")
            //   ],
            // ),
          ],
        );
      }),
    );

  }
}

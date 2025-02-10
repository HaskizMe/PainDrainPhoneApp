import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pain_drain_mobile_app/providers/tens_notifier.dart';
import 'package:pain_drain_mobile_app/widgets/vertical_slider.dart';
import 'package:pain_drain_mobile_app/widgets/horizontal_slider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import '../../../providers/bluetooth_notifier.dart';
import '../../../utils/app_colors.dart';

class TensPopup extends ConsumerStatefulWidget {
  const TensPopup({Key? key}) : super(key: key);

  @override
  ConsumerState<TensPopup> createState() => _TensPopupState();
}

class _TensPopupState extends ConsumerState<TensPopup> with TickerProviderStateMixin{
  //final Stimulus _stimController = Get.find();
  late AnimationController controller1;
  late AnimationController controller2;

  late Animation<double> animation1;
  late Animation<double> animation2;

  bool animationComplete = false;

  @override
  void initState() {
    super.initState();
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

    bool playButtonChannel1 = ref.read(tensNotifierProvider).channels[0].isPlaying;
    bool playButtonChannel2 = ref.read(tensNotifierProvider).channels[1].isPlaying;

    if(playButtonChannel1){
      controller1.forward();
    }
    if(playButtonChannel2){
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
    final tens = ref.watch(tensNotifierProvider);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
      child: Column(
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
                child: // Example usage in a widget:
                StimulusSlider(
                  title: "",
                  minValue: 0.0,
                  maxValue: 100.0,
                  isDecimal: false,
                  measurementType: "%",
                  initialValue: tens.intensity.toDouble(), // You might obtain this from a tensNotifier or another controller.
                  onValueChanged: (newValue) {
                    // Update the TENS stimulus (using your tensNotifier, for example).
                    ref.read(tensNotifierProvider.notifier).updateTens(intensity: newValue.toInt());
                  },
                  onDragCompleted: () {
                    // Optionally, perform any extra logic once dragging stops.
                    print("TENS slider drag completed.");
                  },
                  getCommand: (value) {
                    // Generate the command for the TENS stimulus.
                    // For example, you might use your tensNotifier's getCommand method:
                    return ref.read(bluetoothNotifierProvider.notifier).getCommand("tens");
                  },
                )

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
                  selectedIndex: tens.phase == 0 ? 0 : 1,
                  selectedLabelIndex:(index) async {
                    ref.read(tensNotifierProvider.notifier).updateTens(phase: (index == 0) ? 0 : 180);
                    String command = ref.read(bluetoothNotifierProvider.notifier).getCommand("tens");
                    await ref.read(bluetoothNotifierProvider.notifier).newWriteToDevice(command);
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
                        // selectedIndex: _stimController.getStimulus(_stimController.tensModeChannel1).toInt() - 1, // -1 to make number an index
                        selectedIndex: tens.channels[0].mode - 1,
                        selectedLabelIndex: (index) async {
                          ref.read(tensNotifierProvider.notifier)
                              .updateTens(channelNumber: 1, mode: index + 1);

                          String command = ref.read(bluetoothNotifierProvider.notifier).getCommand("tens");
                          await ref.read(bluetoothNotifierProvider.notifier).newWriteToDevice(command);
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
                              //isPlayingChannel1 = !isPlayingChannel1;
                              if (tens.channels[0].isPlaying) {
                                // _stimController.setStimulus(_stimController.tensPlayButtonChannel1, 1); // 1 means its playing
                                ref.read(tensNotifierProvider.notifier).updateTens(channelNumber: 1, isPlaying: false);
                                controller1.reverse();
                              } else {
                                ref.read(tensNotifierProvider.notifier).updateTens(channelNumber: 1, isPlaying: true);
                                controller1.forward();
                              }
                              // Setting current channel to channel 1
                              String command = ref.read(bluetoothNotifierProvider.notifier).getCommand("tens");
                              ref.read(bluetoothNotifierProvider.notifier).newWriteToDevice(command);
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
                        selectedIndex: tens.channels[1].mode - 1,
                        selectedLabelIndex: (index) async {
                          ref.read(tensNotifierProvider.notifier)
                              .updateTens(channelNumber: 2, mode: index + 1);

                          String command = ref.read(bluetoothNotifierProvider.notifier).getCommand("tens");
                          await ref.read(bluetoothNotifierProvider.notifier).newWriteToDevice(command);
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
                            if (controller2.isCompleted || controller2.isDismissed) {
                              print("Animation done");
                              if (tens.channels[1].isPlaying) {
                                ref.read(tensNotifierProvider.notifier).updateTens(channelNumber: 2, isPlaying: false);
                                controller2.reverse();
                              } else {
                                ref.read(tensNotifierProvider.notifier).updateTens(channelNumber: 2, isPlaying: true);
                                controller2.forward();
                              }
                              String command = ref.read(bluetoothNotifierProvider.notifier).getCommand("tens");
                              ref.read(bluetoothNotifierProvider.notifier).newWriteToDevice(command);
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
                ],
              ),
            )
          ],
        )
    );

  }
}

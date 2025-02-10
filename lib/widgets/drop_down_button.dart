// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pain_drain_mobile_app/models/bluetooth.dart';
// import 'package:pain_drain_mobile_app/models/presets.dart';
// import 'package:pain_drain_mobile_app/models/stimulus.dart';
//
// class DropDownBox extends StatefulWidget {
//   String? selectedItem;
//   List<String>? items;
//   final double widthSize;
//   final String dropDownCategory;
//   DropDownBox({super.key, required this.selectedItem, required this.items, required this.widthSize, required this.dropDownCategory});
//
//   @override
//   _DropDownBoxState createState() => _DropDownBoxState();
// }
//
// class _DropDownBoxState extends State<DropDownBox> {
//   Presets preferences = Get.find();
//   final Stimulus _stimController = Get.find();
//   //final Bluetooth _bleController = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<String>(
//         isExpanded: true,
//         hint: const Row(
//           children: [
//             Expanded(
//               child: Text(
//                 'No Preset Selected',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.black38,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//         items: widget.items?.map((String item) => DropdownMenuItem<String>(
//               value: item,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     item,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               )
//           )).toList(),
//         value: widget.selectedItem,
//         onChanged: (value) {
//           //print(widget.selectedItem);
//           if(widget.dropDownCategory == "waveTypes"){
//             //_stimController.setCurrentWaveType(value!);
//             //widget.selectedItem = _stimController.getCurrentWaveType();
//             String command = _bleController.getCommand("vibration");
//             _bleController.newWriteToDevice(command);
//             setState(() {});
//
//           } else if(widget.dropDownCategory == "presets"){
//             print(value);
//             //value = "preset.$value";
//             preferences.setCurrentPreset(value);
//             widget.selectedItem = preferences.getCurrentPreset();
//
//             setState(() {});
//
//             // setState(() {
//             //   widget.selectedItem = preferences.getCurrentPreset();
//             //   print(widget.selectedItem);
//             //
//             // });
//           }
//           // setState(() {
//           //   preferences.setCurrentPreset(value);
//           //   widget.selectedItem = value!;
//           //   print(widget.selectedItem);
//           //
//           //   //globalValues.setPresetValue(widget.selectedItem!);
//           // });
//         },
//         buttonStyleData: ButtonStyleData(
//           height: 50,
//           width: widget.widthSize,
//           padding: const EdgeInsets.only(left: 14, right: 14),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(14),
//             border: Border.all(
//               color: Colors.black26,
//             ),
//             color: Colors.white,
//           ),
//           elevation: 2,
//         ),
//         iconStyleData: const IconStyleData(
//           icon: Icon(
//             Icons.arrow_drop_down_outlined,
//           ),
//           iconSize: 30,
//           iconEnabledColor: Colors.black,
//           iconDisabledColor: Colors.grey,
//         ),
//         dropdownStyleData: DropdownStyleData(
//           maxHeight: 200,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(14),
//             color: Colors.white,
//           ),
//           scrollbarTheme: ScrollbarThemeData(
//             radius: const Radius.circular(40),
//             thickness: MaterialStateProperty.all(6),
//             thumbVisibility: MaterialStateProperty.all(true),
//           ),
//         ),
//         menuItemStyleData: const MenuItemStyleData(
//           height: 40,
//           padding: EdgeInsets.only(left: 14, right: 14),
//         ),
//       ),
//     );
//   }
// }

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pain_drain_mobile_app/providers/bluetooth_notifier.dart';
import 'package:pain_drain_mobile_app/providers/preset_list_notifier.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pain_drain_mobile_app/models/preset.dart';

class DropDownButton extends ConsumerWidget {
  /// The width of the dropdown button.
  final double widthSize;

  /// The list of available presets.
  final List<Preset> items;

  /// The currently selected preset.
  final Preset? selectedPreset;
  const DropDownButton({super.key, required this.widthSize, required this.items, this.selectedPreset});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<Preset>(
        isExpanded: true,
        hint: const Text(
          'No Preset Selected',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black38,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        // Create a DropdownMenuItem for each Preset.
        items: items.map((Preset preset) {
          return DropdownMenuItem<Preset>(
            value: preset,
            child: Text(
              '${preset.id}.) ${preset.name}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
        // Use the currently selected preset.
        value: selectedPreset,
        onChanged: (Preset? newValue) {
          if (newValue == null) return;
          // Optionally update the current preset notifier.
          ref.read(presetListNotifierProvider.notifier).updateCurrentPreset(preset: newValue);
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: widthSize,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.black26),
            color: Colors.white,
          ),
          elevation: 2,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_drop_down_outlined,
          ),
          iconSize: 30,
          iconEnabledColor: Colors.black,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
          ),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: WidgetStateProperty.all(6),
            thumbVisibility: WidgetStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.symmetric(horizontal: 14),
        ),
      ),
    );
  }
}

// class DropDownBox extends ConsumerStatefulWidget {
//   /// The width of the dropdown button.
//   final double widthSize;
//
//   /// The list of available presets.
//   final List<Preset> items;
//
//   /// The currently selected preset.
//   Preset? selectedPreset;
//
//   DropDownBox({
//     Key? key,
//     required this.widthSize,
//     required this.items,
//     this.selectedPreset,
//   }) : super(key: key);
//
//   @override
//   ConsumerState<DropDownBox> createState() => _DropDownBoxState();
// }
//
// class _DropDownBoxState extends ConsumerState<DropDownBox> {
//   @override
//   Widget build(BuildContext context) {
//     print("My selected preset ${widget.selectedPreset}");
//     print("My preset ${widget.items}");
//
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<Preset>(
//         isExpanded: true,
//         hint: const Text(
//           'No Preset Selected',
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.black38,
//           ),
//           overflow: TextOverflow.ellipsis,
//         ),
//         // Create a DropdownMenuItem for each Preset.
//         items: widget.items.map((Preset preset) {
//           return DropdownMenuItem<Preset>(
//             value: preset,
//             child: Text(
//               '${preset.id}.) ${preset.name}',
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//               overflow: TextOverflow.ellipsis,
//             ),
//           );
//         }).toList(),
//         // Use the currently selected preset.
//         value: widget.selectedPreset,
//         onChanged: (Preset? newValue) {
//           if (newValue == null) return;
//           // Optionally update the current preset notifier.
//           ref.read(presetListNotifierProvider.notifier).updateCurrentPreset(presetKey: newValue);
//           // setState(() {
//           //   widget.selectedPreset = newValue;
//           // });
//         },
//         buttonStyleData: ButtonStyleData(
//           height: 50,
//           width: widget.widthSize,
//           padding: const EdgeInsets.symmetric(horizontal: 14),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(14),
//             border: Border.all(color: Colors.black26),
//             color: Colors.white,
//           ),
//           elevation: 2,
//         ),
//         iconStyleData: const IconStyleData(
//           icon: Icon(
//             Icons.arrow_drop_down_outlined,
//           ),
//           iconSize: 30,
//           iconEnabledColor: Colors.black,
//           iconDisabledColor: Colors.grey,
//         ),
//         dropdownStyleData: DropdownStyleData(
//           maxHeight: 200,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(14),
//             color: Colors.white,
//           ),
//           scrollbarTheme: ScrollbarThemeData(
//             radius: const Radius.circular(40),
//             thickness: WidgetStateProperty.all(6),
//             thumbVisibility: WidgetStateProperty.all(true),
//           ),
//         ),
//         menuItemStyleData: const MenuItemStyleData(
//           height: 40,
//           padding: EdgeInsets.symmetric(horizontal: 14),
//         ),
//       ),
//     );
//   }
// }



// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:pain_drain_mobile_app/models/presets.dart';
// import 'package:pain_drain_mobile_app/providers/bluetooth_notifier.dart';
// import 'package:pain_drain_mobile_app/providers/current_preset_notifier.dart';
// import 'package:pain_drain_mobile_app/providers/preset_list_notifier.dart';
//
// import '../models/preset.dart';
//
// class DropDownBox extends ConsumerStatefulWidget {
//   final double widthSize;
//
//   const DropDownBox({
//     Key? key,
//     required this.widthSize,
//   }) : super(key: key);
//
//   @override
//   ConsumerState<DropDownBox> createState() => _DropDownBoxState();
// }
//
// class _DropDownBoxState extends ConsumerState<DropDownBox> {
//   //int? selectedPresetId;
//
//   @override
//   Widget build(BuildContext context) {
//     final presetList = ref.watch(presetListNotifierProvider);
//     final currentPreset = ref.watch(currentPresetNotifierProvider);
//     print(presetList);
//     print(currentPreset);
//
//     // Initialize the selected preset id if it hasn't been set yet.
//     //selectedPresetId ??= currentPreset?.id;
//
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<int>(
//         isExpanded: true,
//         hint: const Text(
//           'No Preset Selected',
//           style: TextStyle(fontSize: 14, color: Colors.black38),
//           overflow: TextOverflow.ellipsis,
//         ),
//         items: presetList.map((preset) {
//           return DropdownMenuItem<int>(
//             value: preset.id,
//             child: Text(
//               '${preset.id}.) ${preset.name}',
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//               overflow: TextOverflow.ellipsis,
//             ),
//           );
//         }).toList(),
//         value: currentPreset?.id,
//         onChanged: (int? newId) {
//           if (newId == null) return;
//           // Look up the preset by its id.
//           final newPreset = presetList.firstWhere((preset) => preset.id == newId);
//           ref.read(currentPresetNotifierProvider.notifier).updateCurrentPreset(presetKey: newPreset);
//           // setState(() {
//           //   selectedPresetId = newId;
//           // });
//         },
//         buttonStyleData: ButtonStyleData(
//           height: 50,
//           width: widget.widthSize,
//           padding: const EdgeInsets.symmetric(horizontal: 14),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(14),
//             border: Border.all(color: Colors.black26),
//             color: Colors.white,
//           ),
//           elevation: 2,
//         ),
//         iconStyleData: const IconStyleData(
//           icon: Icon(Icons.arrow_drop_down_outlined),
//           iconSize: 30,
//           iconEnabledColor: Colors.black,
//           iconDisabledColor: Colors.grey,
//         ),
//         dropdownStyleData: DropdownStyleData(
//           maxHeight: 200,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(14),
//             color: Colors.white,
//           ),
//           scrollbarTheme: ScrollbarThemeData(
//             radius: const Radius.circular(40),
//             thickness: MaterialStateProperty.all(6),
//             thumbVisibility: MaterialStateProperty.all(true),
//           ),
//         ),
//         menuItemStyleData: const MenuItemStyleData(
//           height: 40,
//           padding: EdgeInsets.symmetric(horizontal: 14),
//         ),
//       ),
//     );
//   }
// }

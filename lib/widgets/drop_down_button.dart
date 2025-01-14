import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pain_drain_mobile_app/models/bluetooth.dart';
import 'package:pain_drain_mobile_app/models/presets.dart';
import 'package:pain_drain_mobile_app/models/stimulus.dart';

class DropDownBox extends StatefulWidget {
  String? selectedItem;
  List<String>? items;
  final double widthSize;
  final String dropDownCategory;
  DropDownBox({super.key, required this.selectedItem, required this.items, required this.widthSize, required this.dropDownCategory});

  @override
  _DropDownBoxState createState() => _DropDownBoxState();
}

class _DropDownBoxState extends State<DropDownBox> {
  Presets preferences = Get.find();
  final Stimulus _stimController = Get.find();
  final Bluetooth _bleController = Get.find();

  @override void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: const Row(
          children: [
            Expanded(
              child: Text(
                'No Preset Selected',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black38,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: widget.items?.map((String item) => DropdownMenuItem<String>(
              value: item,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
          )).toList(),
        value: widget.selectedItem,
        onChanged: (value) {
          //print(widget.selectedItem);
          if(widget.dropDownCategory == "waveTypes"){
            //_stimController.setCurrentWaveType(value!);
            //widget.selectedItem = _stimController.getCurrentWaveType();
            String command = _bleController.getCommand("vibration");
            _bleController.newWriteToDevice(command);
            setState(() {});

          } else if(widget.dropDownCategory == "presets"){
            print(value);
            //value = "preset.$value";
            preferences.setCurrentPreset(value);
            widget.selectedItem = preferences.getCurrentPreset();

            setState(() {});

            // setState(() {
            //   widget.selectedItem = preferences.getCurrentPreset();
            //   print(widget.selectedItem);
            //
            // });
          }
          // setState(() {
          //   preferences.setCurrentPreset(value);
          //   widget.selectedItem = value!;
          //   print(widget.selectedItem);
          //
          //   //globalValues.setPresetValue(widget.selectedItem!);
          // });
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: widget.widthSize,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
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
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:pain_drain_mobile_app/controllers/presets_controller.dart';
import '../main.dart';



class DropDownBox extends StatefulWidget {
  // String? selectedItem;
  // final List<String> items = [
  //   'A_Item1',
  //   'A_Item2',
  //   'A_Item3',
  //   'A_Item4',
  //   'B_Item1',
  //   'B_Item2',
  //   'B_Item3',
  //   'B_Item4',
  // ];
  final List<String> items;
  String? selectedItem;
  // SavedPreset pref = SavedPresets();
  DropDownBox({super.key, required this.items, this.selectedItem});

  @override
  _DropDownBoxState createState() => _DropDownBoxState();
}

class _DropDownBoxState extends State<DropDownBox> {
  // SavedPresets savedPresets = SavedPresets();
  // List<String> dropDownListItems = globalValues.presets;


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
        items: widget.items.map((String item) => DropdownMenuItem<String>(
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
          setState(() {
            widget.selectedItem = value!;
            globalValues.setPresetValue(widget.selectedItem!);
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: 220,
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

      // SizedBox(
      //   width: 300,
      //   child: DropdownButtonFormField2<String>(
      //     isExpanded: true,
      //     decoration: InputDecoration(
      //       // Add Horizontal padding using menuItemStyleData.padding so it matches
      //       // the menu padding when button's width is not specified.
      //       contentPadding: const EdgeInsets.symmetric(vertical: 16),
      //       border: OutlineInputBorder(
      //         borderRadius: BorderRadius.circular(15),
      //       ),
      //       // Add more decoration..
      //     ),
      //     hint: const Text(
      //       'Select Your Gender',
      //       style: TextStyle(fontSize: 14),
      //     ),
      //     items: items
      //         .map((item) => DropdownMenuItem<String>(
      //       value: item,
      //       child: Text(
      //         item,
      //         style: const TextStyle(
      //           fontSize: 14,
      //         ),
      //       ),
      //     ))
      //         .toList(),
      //     validator: (value) {
      //       if (value == null) {
      //         return 'Please select gender.';
      //       }
      //       return null;
      //     },
      //     onChanged: (value) {
      //       //Do something when selected item is changed.
      //     },
      //     onSaved: (value) {
      //       selectedValue = value.toString();
      //     },
      //     buttonStyleData: const ButtonStyleData(
      //       padding: EdgeInsets.only(right: 8),
      //     ),
      //     iconStyleData: const IconStyleData(
      //       icon: Icon(
      //         Icons.arrow_drop_down,
      //         color: Colors.black45,
      //       ),
      //       iconSize: 24,
      //     ),
      //     dropdownStyleData: DropdownStyleData(
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(15),
      //       ),
      //     ),
      //     menuItemStyleData: const MenuItemStyleData(
      //       padding: EdgeInsets.symmetric(horizontal: 16),
      //     ),
      //   ),
      // );
  }
}
import 'package:flutter/material.dart';

void showScrollableSheet(BuildContext context, Widget screen) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SizedBox(
        //height: 800,
        child: Center(
          child: screen,
        ),
      );
    },
  );
}

// showModalBottomSheet(
// constraints: BoxConstraints(
// maxWidth: ScreenSize.screenWidth
// ),
// backgroundColor: Colors.transparent,
// context: context,
// isScrollControlled: true,
// isDismissible: true,
// builder: (BuildContext context) {
// return DraggableScrollableSheet(
// initialChildSize: 0.92,
// // maxChildSize: 0.92,
// // minChildSize: 0.92,
// expand: true,
// builder: (recordPageContext, scrollController) {
// return navigateToWidget;
// },
// );
// },
// )
// class DraggableSheet extends StatefulWidget {
//   const DraggableSheet({Key? key}) : super(key: key);
//
//   @override
//   State<DraggableSheet> createState() => _DraggableSheetState();
// }
//
// class _DraggableSheetState extends State<DraggableSheet> {
//
//   double _sheetPosition = 0.5;
//   final double _dragSensitivity = 600;
//
//   @override
//   Widget build(BuildContext context) {
//     final ColorScheme colorScheme = Theme.of(context).colorScheme;
//
//     return showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return GestureDetector(
//           onTap: () {
//             print("Tapped on the sheet");
//           },
//           child: DraggableScrollableSheet(
//             builder: (BuildContext context, ScrollController scrollController) {
//               return Container(
//                 color: Colors.white,
//                 child: ListView.builder(
//                   controller: scrollController,
//                   itemCount: 50,
//                   itemBuilder: (BuildContext context, int index) {
//                     return ListTile(
//                       title: Text('Item $index'),
//                     );
//                   },
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }

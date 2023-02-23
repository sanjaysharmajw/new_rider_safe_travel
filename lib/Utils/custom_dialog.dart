// import 'package:flutter/material.dart';
// import 'package:overlay_loading_progress/overlay_loading_progress.dart';
//
// import 'exit_alert_dialog.dart';
//
// class CustomDialog{
//   Future<void> stopAlert(BuildContext context) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: true, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Alert'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: const <Widget>[
//                 Text('Dou you want to stop?'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('No'),
//               onPressed: () {
//                 Navigator.pop(context, true);
//               },
//             ),
//             TextButton(
//               child: const Text('Ok'),
//               onPressed: () {
//                 Navigator.pop(context, true);
//                 showExitPopup(context, "Do you want to stop ride?", () async {
//                   OverlayLoadingProgress.start(context);
//                   await endRide();
//                 });
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
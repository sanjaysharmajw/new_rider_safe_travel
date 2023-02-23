// import 'package:flutter/material.dart';
// import 'package:overlay_loading_progress/overlay_loading_progress.dart';
//
// class ReceivedAlert extends StatelessWidget {
//   const ReceivedAlert({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return  showDialog(
//       context: context,
//       barrierDismissible: true, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//             title: const Text('Alert'),
//             content: SingleChildScrollView(
//               child: ListBody(
//                 children: const <Widget>[
//                   Text('Do you received support?'),
//                 ],
//               ),
//             ),
//             actions: <Widget>[
//         TextButton(
//         child: const Text('No'),
//         onPressed: () {
//         Navigator.pop(context, true);
//         },
//         ),
//         TextButton(
//         child: const Text('Yes'),
//         onPressed: () {
//         });
//       },
//     ),
//   }
// }

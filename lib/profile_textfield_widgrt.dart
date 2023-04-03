//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import 'LoginModule/custom_color.dart';
//
// class ProfileTextField extends StatelessWidget {
//   const ProfileTextField({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return    Row(
//       children: [
//         Row(
//           children: [
//             Padding(
//               padding: EdgeInsets.only(
//                   left: 15, right: 5, top: 0, bottom: 0),
//               child:  Icon(Icons.email_outlined),
//             ),
//             Text(
//               "Email Id",
//               style: TextStyle(
//                   fontSize: 14.sp,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: "Gilroy",
//                   color: CustomColor.riderprofileColor),
//             ),
//           ],
//         ),
//         VerticalDivider(width: 55.0),
//         Expanded(
//             flex: 2,
//             child: TextFormField(
//               readOnly: true,
//               validator: (value) {
//                 if (value == null) {
//                   return 'Please enter your email Id.';
//                 }
//                 return null;
//               },
//
//               style:  TextStyle(
//                   fontSize: 13.sp,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: "Gilroy",
//                   color: CustomColor.riderprofileColor),
//               keyboardType: TextInputType.emailAddress,
//               maxLines: 1,
//               controller: emailController,
//               decoration:  InputDecoration(
//
//                 enabled: false,
//                 hintText:  '${snapshot.data![index].emailId.toString()}' == "null" ? " " : '${snapshot.data![index].emailId.toString()}',
//                 hintStyle: TextStyle(
//                     fontSize: 13.sp,
//
//                     fontFamily: "Gilroy",
//                     color: CustomColor.riderprofileColor),
//                 border: UnderlineInputBorder(),
//                 enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(
//                         width: 1, color: CustomColor.yellow)),
//                 focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(
//                       width: 1, color: Colors.amberAccent),
//                 ),
//               ),
//             )),
//
//       ],
//     ),
//
// }

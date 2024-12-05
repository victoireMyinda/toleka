// // ignore_for_file: use_build_context_synchronously, duplicate_ignore
// import 'package:flutter/material.dart';
// import 'package:toleka/presentation/screens/singupkelasi/signup-step3kelasi.dart';


// class TransAcademiaYesNoDialog {
//   static show(BuildContext context, String? text) {
//     showDialog<void>(
//         barrierDismissible: true,
//         context: context,
//         builder: (BuildContext context) {
//           Widget okButton = TextButton(
//             child: const Text(
//               "NON",
//               style: TextStyle(color: Colors.red),
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           );

//           Widget nopeButton = TextButton(
//             child: const Text("OUI"),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => SignupStep3(backNavigation: false,)),
//               );
//             },
//           );

//           AlertDialog alert = AlertDialog(
//             // title: const Text("Leave"),
//               shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//             content: Text(text.toString()),
//             actions: [
//               nopeButton,
//               okButton,
//             ],
//           );
//           return alert;
//         });
//   }
// }

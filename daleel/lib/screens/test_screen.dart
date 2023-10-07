// import 'dart:io';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:minio/io.dart';
// import 'dart:async';

// import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:dio/dio.dart';
// // import 'package:dospace/dospace.dart' as dospace;
// import 'package:amplify_storage_s3/amplify_storage_s3.dart';
// // import 'package:file_picker/file_picker.dart';

// import 'package:daleel/providers/users.dart';

// class TestScreen extends StatefulWidget {
//   static const routeName = '/test-screen';
//   const TestScreen({Key? key}) : super(key: key);

//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }

// class _TestScreenState extends State<TestScreen> {
//   // Spaces DOSpace = Spaces(
//   //     region: 'sgp1',
//   //     accessKey: 'DO00E376FHFXLA4QX3EE',
//   //     secretKey: 'XJ6KqAAlgodndSY/tfURibgmnKxv6n6DA/bCyXGzRBo');
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: ElevatedButton(
//             child: Text('upload file to DO spaces'),
//             onPressed: () async {
//               File file = File('path');

//               // FilePickerResult? result =
//               //     await FilePicker.platform.pickFiles(type: FileType.any);

//               if (result != null) {
//                 file = File(result.files.single.path!);
//               } else {
//                 // User canceled the picker
//               }

//               Amplify.Storage.uploadFile(local: file, key: '${file.path}');
              

//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

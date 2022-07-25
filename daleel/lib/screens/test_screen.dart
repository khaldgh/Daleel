import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:daleel/models/user.dart';
import 'package:daleel/providers/offers.dart';
import 'package:daleel/providers/places.dart';
import 'package:daleel/providers/users.dart';
// import 'package:daleel/screens/pdf_viewer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:images_picker/images_picker.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import 'dart:io';

import 'package:shimmer/shimmer.dart';
// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  static Future<dynamic> loadNetwork(String url) async {
    final response = await Dio().get(
      url,
      options: Options(responseType: ResponseType.bytes),
    );
    final bytes = response.data;

    return bytes;
  }

  File? file = File('text');
  @override
  Widget build(BuildContext context) {
    var users = Provider.of<Users>(context, listen: false);
    // var offers = Provider.of<Offers>(context, listen: false);
    // String url =
    //     'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf';
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(child: Text('كيف الحال'), onPressed: users.whoami),
          Text(('كيف الحال'), style: TextStyle(fontFamily: 'Frutiger')),
        ],
      )
);
    
  }
}

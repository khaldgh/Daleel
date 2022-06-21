import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:daleel/models/user.dart';
import 'package:daleel/providers/places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:images_picker/images_picker.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  PdfViewerController _pdfViewController = PdfViewerController();

  @override
  Widget build(BuildContext context) {
    var places = Provider.of<Places>(context, listen: false);

    return Center(
      child: IconButton(
        icon: Icon(Icons.person_search),
        onPressed: () async {
          places.getOffers();
        }
      ),
    );
  }
}

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

class OffersScreen extends StatefulWidget {
  static const routeName = '/offers-screen';

  const OffersScreen({Key? key}) : super(key: key);

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {



  @override
  Widget build(BuildContext context) {
    var places = Provider.of<Places>(context, listen: false);

    return StaggeredGridView.countBuilder(
        itemCount: 10,
        crossAxisCount: 2,
        crossAxisSpacing: 2,
        itemBuilder: (BuildContext context, int index) => IgnorePointer(
          child: Container(
              height: 300,
              width: 600,
              child: SfPdfViewer.network(
                'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
                canShowScrollHead: false,
                 
              )),
        ),
        staggeredTileBuilder: (int i) => StaggeredTile.fit(1));
  }
}

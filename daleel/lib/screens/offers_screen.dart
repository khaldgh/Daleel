import 'dart:io';

import 'package:daleel/models/user.dart';
import 'package:daleel/providers/offers.dart';
import 'package:daleel/providers/places.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:images_picker/images_picker.dart';
// import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:provider/provider.dart';
// import 'package:pdf_render/pdf_render.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class OffersScreen extends StatefulWidget {
  static const routeName = '/offers-screen';

  const OffersScreen({Key? key}) : super(key: key);

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  late Future<List<File>> futureOffers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureOffers = Provider.of<Offers>(context, listen: false).offerFiles();
  }

  @override
  Widget build(BuildContext context) {
    var places = Provider.of<Places>(context, listen: false);
    var offers = Provider.of<Offers>(context, listen: false);

    return Scaffold(
      body: FutureBuilder(
          future: futureOffers,
          builder: (BuildContext context, AsyncSnapshot<List<File>> snapshot) {
            List<File> snp = snapshot.data ?? [File('')];
            // print(snapshot.data![0].path);
            return StaggeredGridView.countBuilder(
                // itemCount: snapshot.data!.length,
                crossAxisCount: 2,
                crossAxisSpacing: 2,
                itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: () => print('hi'),
                      child: IgnorePointer(
                        child: Container(
                          height: 300,
                          width: 600,
                          // child: PdfViewer.openFile(
                          // snp![index].path ,
                          // ),
                        ),
                      ),
                    ),
                staggeredTileBuilder: (int i) => StaggeredTile.fit(1));
          }),
    );
  }
}

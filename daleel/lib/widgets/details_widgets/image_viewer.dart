import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:daleel/providers/places.dart';

class ImageViewer extends StatefulWidget {
  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    final places = Provider.of<Places>(context).favoritePlaces;
    return Flexible(
      fit: FlexFit.tight,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: places.length,
        itemBuilder: (ctx,i) => Container(
          height: 250,
          width: double.infinity,
          margin: EdgeInsets.all(3),
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Image.network(places[i].title!),
        ),
      ),
    );
  }
}

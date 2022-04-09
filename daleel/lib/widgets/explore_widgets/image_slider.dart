import 'dart:convert';

import 'package:daleel/models/place.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

import 'package:daleel/providers/places.dart';

class ImageSlider extends StatelessWidget {
  List<String> provinces = [
    'Eastern',
    'Western',
    'Central',
    'Southern',
    'northern'
  ];
  @override
  Widget build(BuildContext context) {
    final placesData = Provider.of<Places>(context);
    final size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return GFCarousel(
      autoPlay: true,
      pauseAutoPlayOnTouch: Duration(seconds: 10),
      items: provinces.map(
        (place) {
          return ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(width/6.7)),
            child: Container(
                color: Colors.lightBlue,
                width: double.infinity,
                margin: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(place),
                )),
          );
        },
      ).toList(),
    );
  }
}

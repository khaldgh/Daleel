import 'dart:io';
import 'package:daleel/models/category.dart';
import 'package:daleel/models/city.dart';
import 'package:daleel/models/neighborhood.dart';
import 'package:daleel/models/place.dart';
import 'package:daleel/providers/places.dart';
import 'package:daleel/widgets/add-place-widgets/add_place_text_form_field.dart';
import 'package:daleel/widgets/add-place-widgets/category_chip.dart';
import 'package:daleel/widgets/add-place-widgets/city_chip.dart';
import 'package:daleel/widgets/add-place-widgets/neighborhood_chip.dart';
import 'package:daleel/widgets/home-widgets/image_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:images_picker/images_picker.dart';
import 'package:provider/provider.dart';

class TestScreen2 extends StatefulWidget {
  static const routeName = '/test-screen2';
  const TestScreen2({Key? key}) : super(key: key);

  @override
  State<TestScreen2> createState() => _TestScreen2State();
}

class _TestScreen2State extends State<TestScreen2> {
  @override
  Widget build(BuildContext context) {
    final places = Provider.of<Places>(context).getPlaces();
    return Scaffold(
        body: FutureBuilder(
      future: places,
      builder: (BuildContext context, AsyncSnapshot snapshot) =>
          StaggeredGridView.countBuilder(
        crossAxisCount: 3,
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(1.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF40D8AB), Color(0xFF35A8E1)]),),
              child: Text(snapshot.data[index].title, style: TextStyle(color: Colors.white),),
            ),
          ),
        ),
        staggeredTileBuilder: (index) => StaggeredTile.count(1, 1),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
    ));
  }
}

import 'package:daleel/models/category.dart';
import 'package:daleel/models/neighborhood.dart';
import 'package:daleel/models/place.dart';
import 'package:daleel/providers/places.dart';
import 'package:daleel/widgets/add-place-widgets/add_place_text_form_field.dart';
import 'package:daleel/widgets/admin-page-widgets/admin_form.dart';
import 'package:daleel/widgets/admin-page-widgets/admin_text_form_field.dart';
import 'package:daleel/widgets/admin-page-widgets/optional_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class TestScreen extends StatefulWidget {
  static const routeName = 'testScreen';
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  Place userPlace = Place(
    // id: 0,
    title: 'default title',
    description: 'default desc',
    category: Category(categoryId: 5, category: 'مقاهي'),
    approved: false,
    phone: 0,
    instagram: 'default insta',
    website: 'default web',
    neighborhoods: [Neighborhood(neighborhoodId: 6, neighborhood: 'العليا')],
    weekdays: [
      's',
      'm',
      't',
      'w',
      't',
      'f',
      's',
    ],
    images: [],
    // isFavorite: null,
    // time: null
  );

  String category = 'Ca';
  String city = 'Ci';
  String neighborhood = 'n';

  void addCategory(Category category) {
    userPlace = Place(
        title: userPlace.title,
        description: userPlace.description,
        approved: userPlace.approved,
        category: category,
        images: userPlace.images,
        instagram: userPlace.instagram,
        neighborhoods: userPlace.neighborhoods,
        phone: userPlace.phone,
        website: userPlace.website,
        weekdays: userPlace.weekdays);
  }

  void addNeighborhood(Neighborhood? neighborhood) {
    userPlace = Place(
        title: userPlace.title,
        description: userPlace.description,
        approved: userPlace.approved,
        category: userPlace.category,
        images: userPlace.images,
        instagram: userPlace.instagram,
        neighborhoods: [neighborhood!],
        phone: userPlace.phone,
        website: userPlace.website,
        weekdays: userPlace.weekdays);
  }

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<Places>(context, listen: false).getPreApprovedPlaces();
    super.initState();
  }

  void updateScreen() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var placesProvider = Provider.of<Places>(context, listen: false);
    Future<List<Place>> futureFunction = placesProvider.getPreApprovedPlaces();
    return FutureBuilder(
        future: futureFunction,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<Place> places = snapshot.data ?? [];
          return ListView.builder(
            itemCount: places.length,
            itemBuilder: (BuildContext context, int index) => Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(54, 4, 6, 22)),
                width: 350,
                height: 750,
                margin: EdgeInsets.only(top: 20),
                child: Stack(
                  children: [
                    Positioned(
                      child: AdminForm(index: index, listOfPlaces: places, updateScreen: updateScreen,),
                      top: 20,
                      right: 30,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

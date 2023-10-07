import 'package:daleel/models/category.dart';
import 'package:daleel/models/neighborhood.dart';
import 'package:daleel/models/place.dart';
import 'package:daleel/providers/places.dart';
import 'package:daleel/widgets/add-place-widgets/add_place_text_form_field.dart';
import 'package:daleel/widgets/admin-page-widgets/admin_form.dart';
import 'package:daleel/widgets/admin-page-widgets/admin_new_place.dart';
import 'package:daleel/widgets/admin-page-widgets/admin_text_form_field.dart';
import 'package:daleel/widgets/admin-page-widgets/optional_text_form_field.dart';
import 'package:daleel/widgets/admin-page-widgets/weekday_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class AdminScreen extends StatefulWidget {
  static const routeName = '/admin-screen';
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> with TickerProviderStateMixin {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TabController? _tabController;

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
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController!.dispose();
    super.dispose();
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
          return DefaultTabController(
            initialIndex: 1,
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                bottom: TabBar(
                  tabs: [
                    Tab(
                        icon: Icon(Icons.add_business),
                        child: Text('مكان جديد')),
                    Tab(
                        icon: Icon(Icons.assignment_turned_in_outlined),
                        child: Text('مراجعة')),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  AdminNewPlace(),
                  Container()
                  // WeekdayPicker()
                ],
              ),
            ),
          );
        });
  }
}

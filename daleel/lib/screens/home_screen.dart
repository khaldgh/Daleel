import 'package:daleel/screens/add_place_screen.dart';
import 'package:daleel/screens/favorite_screen.dart';
import 'package:daleel/screens/preferences_screen.dart';
import 'package:daleel/screens/test_screen.dart';
import 'package:daleel/screens/test_screen2.dart';
import 'package:flutter/material.dart';

import 'package:daleel/screens/settings_screen.dart';
import 'package:daleel/screens/explore_screen.dart';
import 'package:daleel/widgets/home-widgets/my_navigation_bar.dart';
import 'package:daleel/widgets/home-widgets/places_grid.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homescreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 3;

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> _screens = [
    // PreferencesScreen(),
    SettingsScreen(),
    FavoriteScreen(),
    // TestScreen(),
    // AddPlaceScreen(),
    ExploreScreen(),
    PlacesGrid(),
    // AdminScreen()
    // PlacesCollectionScreen()
  ];

  @override
  Widget build(BuildContext context) {
    // final placeProvider = Provider.of<Places>(context);
    // final allImages = placeProvider.allTitles;
    return Scaffold(
        extendBody: true,
        body: _screens[selectedIndex],
        bottomNavigationBar: MyNavigationBar(
          selectedIndex: selectedIndex,
          changeIndex: changeIndex,
        ));
  }
}

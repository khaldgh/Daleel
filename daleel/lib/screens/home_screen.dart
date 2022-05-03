import 'package:daleel/screens/add-place-screen.dart';
import 'package:daleel/screens/test_screen.dart';
import 'package:daleel/widgets/add-place-widgets/category_chip.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:daleel/screens/settings_screen.dart';
import 'package:daleel/screens/login_screen.dart';
import 'package:daleel/screens/explore_screen.dart';
import 'package:daleel/screens/preferences_screen.dart';
import 'package:daleel/screens/capital_places.dart';
import 'package:daleel/widgets/explore_widgets/category_detail_item.dart';
import 'package:daleel/widgets/home_widgets/my_navigation_bar.dart';
import 'package:daleel/widgets/home_widgets/places_grid.dart';
import 'package:daleel/providers/places.dart';
import 'package:daleel/widgets/home_widgets/filter_chip_widget.dart';


class HomeScreen extends StatefulWidget {
  static const routeName = '/homescreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> _screens = [
    PlacesGrid(),
    ExploreScreen(),
    AddPlaceScreen(),
    SettingsScreen(),
    // PrefrencesScreen()
    TestScreen()
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

import 'package:daleel/providers/offers.dart';
import 'package:daleel/screens/add-place-screen.dart';
import 'package:daleel/screens/settings_screen.dart';
import 'package:daleel/screens/login_screen.dart';
import 'package:daleel/screens/preferences_screen.dart';
import 'package:daleel/screens/capital_places.dart';
import 'package:daleel/screens/test_screen.dart';
import 'package:daleel/widgets/admin-page_widgets/admin_form.dart';
import 'package:daleel/widgets/home_widgets/filter_chip_widget.dart';
import 'package:daleel/widgets/explore_widgets/category_detail_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import './screens/details_screen.dart';
import './screens/explore_screen.dart';
import './providers/places.dart';
import './screens/home_screen.dart';
import './screens/search_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    var cookie = FlutterSecureStorage().read(key: 'cookie');
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Places(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Offers(),
        ),
      ],
      child: FutureBuilder(
        future: cookie,
        builder: (BuildContext context, AsyncSnapshot snapshot) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Daleel',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: snapshot.hasData ? HomeScreen() : LoginScreen(),
            routes: {
              LoginScreen.routeName: (ctx) => LoginScreen(),
              PrefrencesScreen.routeName: (ctx) => PrefrencesScreen(),
              HomeScreen.routeName: (ctx) => HomeScreen(),
              DetailsScreen.routeName: (ctx) => DetailsScreen(),
              ExploreScreen.routeName: (ctx) => ExploreScreen(),
              SettingsScreen.routeName: (ctx) => SettingsScreen(),
              CategoryDetailItem.routeName: (ctx) => CategoryDetailItem(),
              SearchDetailsScreen.routeName: (ctx) => SearchDetailsScreen(),
              FilterChipWidget.routeName: (ctx) => FilterChipWidget(),
              AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
              AdminForm.routeName: (ctx) => AdminForm(),
              TestScreen.routeName: (ctx) => TestScreen(),
            }),
      ),
    );
  }
}

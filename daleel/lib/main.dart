import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:daleel/providers/offers.dart';
import 'package:daleel/screens/add_place_screen.dart';
import 'package:daleel/screens/offers_screen.dart';
import 'package:daleel/screens/places_collection_screen.dart';
import 'package:daleel/screens/settings_screen.dart';
import 'package:daleel/screens/login_screen.dart';
import 'package:daleel/screens/preferences_screen.dart';
import 'package:daleel/screens/admin_screen.dart';
import 'package:daleel/widgets/admin-page-widgets/admin_form.dart';
import 'package:daleel/widgets/home-widgets/filter_chip_widget.dart';
import 'package:daleel/widgets/explore-widgets/category_detail_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

// Generated in previous step
import 'amplifyconfiguration.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    // AmplifyAnalyticsPinpoint analyticsPlugin = AmplifyAnalyticsPinpoint();

    AmplifyStorageS3 storagePlugin = AmplifyStorageS3();

    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();

    await Amplify.addPlugins([storagePlugin, authPlugin]);

    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }

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
              PreferencesScreen.routeName: (ctx) => PreferencesScreen(),
              HomeScreen.routeName: (ctx) => HomeScreen(),
              DetailsScreen.routeName: (ctx) => DetailsScreen(),
              ExploreScreen.routeName: (ctx) => ExploreScreen(),
              SettingsScreen.routeName: (ctx) => SettingsScreen(),
              CategoryDetailItem.routeName: (ctx) => CategoryDetailItem(),
              SearchDetailsScreen.routeName: (ctx) => SearchDetailsScreen(),
              FilterChipWidget.routeName: (ctx) => FilterChipWidget(),
              AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
              AdminForm.routeName: (ctx) => AdminForm(),
              AdminScreen.routeName: (ctx) => AdminScreen(),
              PlacesCollectionScreen.routeName: (ctx) => PlacesCollectionScreen(),
              OffersScreen.routeName: (ctx) => OffersScreen(),
            }),
      ),
    );
  }
}

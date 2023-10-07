import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:daleel/providers/offers.dart';
import 'package:daleel/providers/subcategories.dart';
import 'package:daleel/providers/users.dart';
import 'package:daleel/screens/add_place_screen.dart';
import 'package:daleel/screens/offers_screen.dart';
import 'package:daleel/screens/places_collection_screen.dart';
import 'package:daleel/screens/settings_preferences_screen.dart';
import 'package:daleel/screens/settings_screen.dart';
import 'package:daleel/screens/login_screen.dart';
import 'package:daleel/screens/preferences_screen.dart';
import 'package:daleel/screens/admin_screen.dart';
import 'package:daleel/screens/test_screen.dart';
import 'package:daleel/screens/test_screen2.dart';
import 'package:daleel/widgets/admin-page-widgets/admin_form.dart';
import 'package:daleel/widgets/home-widgets/filter_chip_widget.dart';
import 'package:daleel/widgets/explore-widgets/category_detail_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
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

  final ThemeData theme = ThemeData(fontFamily: 'Frutiger');

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
        ChangeNotifierProvider(
          create: (ctx) => Users(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Subcategories(),
        ),
      ],
      child: FutureBuilder(
        future: cookie,
        builder: (BuildContext context, AsyncSnapshot snapshot) =>
            MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Daleel',
          theme: theme.copyWith(
            primaryColor: Color(0xFF35A8E1),
            // colorScheme: theme.colorScheme.copyWith(secondary: Color(0xFF40D8AB)),
            // iconTheme: IconThemeData(color:Color(0xFF40D8AB) ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Color(0xFF35A8E1)),
            // textButtonTheme: TextButtonThemeData(style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Color(0xFF40D8AB)))),
          ),
          routerConfig: GoRouter(
            initialLocation: HomeScreen.routeName,
            redirect:(context, state) {
              if(!snapshot.hasData){
                return LoginScreen.routeName;
              }
              return null;
            },
            routes: [
              GoRoute(
                path: HomeScreen.routeName,
                builder: (context, state) =>
                    // snapshot.hasData ? HomeScreen() : LoginScreen(),
                    HomeScreen()
              ),
              GoRoute(
                path: LoginScreen.routeName,
                builder: (context, state) => LoginScreen()
              ),
              GoRoute(
                path: PreferencesScreen.routeName,
                builder: (context, state) => PreferencesScreen(),
              ),
              GoRoute(
                path: '${DetailsScreen.routeName}/:placeId',
                builder: (context, state) => DetailsScreen(arguments: int.parse(state.params['placeId']!))
              ),
              GoRoute(
                path: ExploreScreen.routeName,
                builder: (context, state) => ExploreScreen()
              ),
              GoRoute(
                path: SettingsScreen.routeName,
                builder: (context, state) => SettingsScreen()
              ),
              GoRoute(
                path: CategoryDetailItem.routeName,
                builder: (context, state) => CategoryDetailItem()
              ),
              GoRoute(
                path: SearchDetailsScreen.routeName,
                builder: (context, state) => SearchDetailsScreen()
              ),
              GoRoute(
                path: FilterChipWidget.routeName,
                builder: (context, state) => FilterChipWidget()
              ),
              GoRoute(
                path: AddPlaceScreen.routeName,
                builder: (context, state) => AddPlaceScreen()
              ),
              GoRoute(
                path: AdminForm.routeName,
                builder: (context, state) => AdminForm()
              ),
              GoRoute(
                path: AdminScreen.routeName,
                builder: (context, state) => AdminScreen()
              ),
              GoRoute(
                path: PlacesCollectionScreen.routeName,
                builder: (context, state) => PlacesCollectionScreen()
              ),
              GoRoute(
                path: OffersScreen.routeName,
                builder: (context, state) => OffersScreen()
              ),
              GoRoute(
                path: SettingsPreferencesScreen.routeName,
                builder: (context, state) => SettingsPreferencesScreen()
              ),
              GoRoute(
                path: TestScreen2.routeName,
                builder: (context, state) => TestScreen2()
              ),
            ],
          ),
          // home: snapshot.hasData ? HomeScreen() : LoginScreen(),
          // routes: {
          //   LoginScreen.routeName: (ctx) => LoginScreen(),
          //   PreferencesScreen.routeName: (ctx) => PreferencesScreen(),
          //   HomeScreen.routeName: (ctx) => HomeScreen(),
          //   DetailsScreen.routeName: (ctx) => DetailsScreen(arguments: ModalRoute.of(ctx)!.settings.arguments as int),
          //   ExploreScreen.routeName: (ctx) => ExploreScreen(),
          //   SettingsScreen.routeName: (ctx) => SettingsScreen(),
          //   CategoryDetailItem.routeName: (ctx) => CategoryDetailItem(),
          //   SearchDetailsScreen.routeName: (ctx) => SearchDetailsScreen(),
          //   FilterChipWidget.routeName: (ctx) => FilterChipWidget(),
          //   AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
          //   AdminForm.routeName: (ctx) => AdminForm(),
          //   AdminScreen.routeName: (ctx) => AdminScreen(),
          //   PlacesCollectionScreen.routeName: (ctx) => PlacesCollectionScreen(),
          //   OffersScreen.routeName: (ctx) => OffersScreen(),
          //   SettingsPreferencesScreen.routeName: (ctx) => SettingsPreferencesScreen(),
          //   TestScreen2.routeName: (ctx) => TestScreen2(),
          // }
        ),
      ),
    );
  }
}

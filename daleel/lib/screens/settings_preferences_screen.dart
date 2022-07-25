import 'package:daleel/models/category.dart';
import 'package:daleel/widgets/settings-screen-widgets/settings_screen_chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/home-widgets/chip_widget.dart';
import '../providers/places.dart';

class SettingsPreferencesScreen extends StatefulWidget {
  static const routeName = '/settings_preferences_screen';
  const SettingsPreferencesScreen({Key? key}) : super(key: key);

  @override
  _SettingsPreferencesScreenState createState() =>
      _SettingsPreferencesScreenState();
}

class _SettingsPreferencesScreenState extends State<SettingsPreferencesScreen> {

late Future<List<Category>> categories;
late Future<List<Category>> selectedPrefs;
late Future<dynamic> futures;
late Places places;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    places = Provider.of<Places>(context, listen: false);
    categories = places.getCategories();
    selectedPrefs = places.getUserPreferences();
    futures = Future.wait([categories, selectedPrefs]);

  }


    

  @override
  Widget build(BuildContext context) {
    


    return Scaffold(
        backgroundColor: Colors.blue[200],
        body: FutureBuilder(
          future: futures,
          builder: (BuildContext context, AsyncSnapshot snapshot) => Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/ku_b-1-768x495.jpg'),
                    opacity: 0.6,
                    fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 35.0),
                  child: Text(
                    ':اختر الاماكن المفضلة لديك',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Wrap(
                    children: [
                      for (Category i in snapshot.data![0]!)
                        SettingsChipWidget(
                          i,
                          snapshot.data![1]!,
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () async {
                      await places.setUserPreferences(
                           snapshot.data[1],
                          context,
                          settingsScreen: true);
                    },
                    child: Text(
                      'استمر',
                      style: TextStyle(
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(0.0, 5.0),
                              blurRadius: 3.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ],
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

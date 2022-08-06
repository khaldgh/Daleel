import 'package:daleel/models/category.dart';
import 'package:daleel/models/place.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/home-widgets/chip_widget.dart';
import '../providers/places.dart';

class PreferencesScreen extends StatefulWidget {
  static const routeName = '/preferences_screen';
  const PreferencesScreen({Key? key}) : super(key: key);

  @override
  _PreferencesScreenState createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  late Future<List<Category>> futureCategories;
  late Places places;
  var _selected = false;
    List<Category> userPreferences = [];

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    places = Provider.of<Places>(context, listen: false);
    futureCategories = places.getCategories();
  }
    
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
        backgroundColor: Colors.blue[200],
        body: FutureBuilder(
          future: futureCategories,
          builder:
              (BuildContext context, AsyncSnapshot<List<Category>> snapshot) =>
                  Container(
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
                      for (var i in snapshot.data!)
                        ChipWidget(i, userPreferences),
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
                          userPreferences, context, settingsScreen: false);
                    },
                    child: Text(
                      'استمر',
                      style: TextStyle(
                          color: Colors.red[700],
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

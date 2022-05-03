import 'package:daleel/models/place.dart';
import 'package:daleel/screens/test_screen.dart';
import 'package:daleel/widgets/home_widgets/chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:daleel/providers/places.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = 'settings-screen';
  SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    Places places = Provider.of<Places>(context);
    return SafeArea(
      child: Scaffold(
          // appBar: AppBar(),
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: () async {
                  var test = await Provider.of<Places>(context, listen: false);
                  test.getPlaces();
                  // print(test.preApprovedList);
                  // formPlces.forEach((;element) {print(element.category);});
                  // test.map((e) => print(e)).toList();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('profile', style: TextStyle(fontSize: 23)),
                    Icon(Icons.tag_faces_outlined)
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('preferences', style: TextStyle(fontSize: 23)),
                  Icon(Icons.edit)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('history', style: TextStyle(fontSize: 23)),
                  Icon(Icons.history)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('settings', style: TextStyle(fontSize: 23)),
                  Icon(Icons.settings)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('language', style: TextStyle(fontSize: 23)),
                  Icon(Icons.language)
                ],
              ),
              InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed(TestScreen.routeName);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('admin', style: TextStyle(fontSize: 23)),
                    Icon(Icons.admin_panel_settings)
                  ],
                ),
              ),
              TextButton(
                child: Text('sign out',
                    style: TextStyle(fontSize: 20, color: Colors.red[900])),
                onPressed: () async {
                  places.signout(context);
                },
              ),
              SizedBox(height: 10,)
            ],
          )),
    );
  }
}

import 'package:daleel/models/user.dart';
import 'package:daleel/providers/offers.dart';
import 'package:daleel/providers/users.dart';
import 'package:daleel/screens/admin_screen.dart';
import 'package:daleel/screens/settings_preferences_screen.dart';
import 'package:daleel/widgets/settings-screen-widgets/custom_settings_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:daleel/providers/places.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings-screen';
  SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late Future<User> futureUser;
  late Users users;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    users = Provider.of<Users>(context, listen: false);
    Places places = Provider.of<Places>(context, listen: false);
    Future<User> currentUser() async {
      User user = await users.whoami();
      String userImg = await places.getDownloadUrl(
          folderName: 'profilePics', id: user.user_id);
      user.profilePic = userImg;
      return user;
    }

    futureUser = currentUser();
  }

  Widget openSnackbar() {
    Provider.of<Places>(context, listen: false).openSnackBar(context);
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 50,
          ),
          FutureBuilder(
            future: futureUser,
            builder: (BuildContext ctx, AsyncSnapshot<User> snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : snapshot.hasError ? openSnackbar() : Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Stack(children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(snapshot.data!.profilePic!),
                              radius: 80,
                            ),
                            Positioned(
                                bottom: 0.1,
                                left: 5,
                                child: Container(
                                  height: 35,
                                  width: 150,
                                  color: Colors.white38,
                                  child: Icon(Icons.add_a_photo),
                                ))
                          ]),
                          Text(snapshot.data!.username!),
                          SizedBox(
                            height: 30,
                          ),
                          CustomSettingsButton(
                            icon: Icons.edit,
                            label: 'التفضيلات',
                            onTap: () async {
                              GoRouter.of(context).go(
                                  SettingsPreferencesScreen.routeName);
                            },
                          ),
                          CustomSettingsButton(
                            icon: Icons.history,
                            label: 'السجل',
                            onTap: () async {
                              var user = await users.whoami();
                              print(user.username);
                            },
                          ),
                          // CustomSettingsButton(
                          //   icon: Icons.language,
                          //   label: 'اللغة',
                          // ),
                          CustomSettingsButton(
                            icon: Icons.admin_panel_settings,
                            label: 'الاشراف',
                            onTap: () {
                              GoRouter.of(context)
                                  .go(AdminScreen.routeName);
                            },
                          ),
                          TextButton(
                            child: Text('تسجيل الخروج',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.red[900])),
                            onPressed: () async {
                              users.signout(context);
                            },
                          ),
                        ],
                      )),
          ),
        ],
      )),
    );
  }
}

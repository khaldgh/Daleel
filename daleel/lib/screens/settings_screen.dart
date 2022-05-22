import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:daleel/models/place.dart';
import 'package:daleel/screens/admin_screen.dart';
import 'package:daleel/widgets/home_widgets/chip_widget.dart';
import 'package:daleel/widgets/settings-screen-widgets/custom_settings_button.dart';
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
  // String imageLink =
  //     'https://daleel2c599cd061ac49af939fc643b943c84c50649-dev.s3.ap-south-1.amazonaws.com/public/ExampleKy?response-content-disposition=inline&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEMf%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCWV1LXdlc3QtMyJHMEUCIQCnv72okXSXuPsffe7vXpOwoiV%2FjjOzHeDLEQWUFhed6AIgL4EYZlm%2FUvuVTdO6S%2Fls2wTKlBjHPBD1MYhTxqKiymEq7QIIoP%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FARABGgw0MzMyNTU0ODU4NjkiDMQFdjCIdQUVIr9ydyrBAoDYfdR5lfOo2p9tgNNFg29WOlfYyJEogs4O3xgEhWgjPZf5rOHNKXIda4AHZutxtROI46MhM6UMkk5ZD%2BnAQmQ1sLTTjYQsyO4x%2FvhNimuOhSlDA1zNBVDfScI%2FCcQ0I65ITAxekN54IfywEtpdZhBfnDZ4tMv8hWMmpphuTelIpaa7FaCqnZJAJtc0Y3v5HQ5%2FR3p%2Bf5NNS6frKBVp9qci%2F0129PRh1wk9ghL5HB4GPZ3XI0nYq%2BTEr359fnLKkD603W4LOpvRYFyxVY6zbNmw%2BHvHSrG5l3Sb44ZaqF7VquwSXVwNhlXjsgcMGR5dqhy54qXEYGnV3f9MqpDj9RE9190TVrsXT6tM6heTx5MolkUjxhQ%2FGH0GYKJFzogJHFFlNOnoh9hY9YG7LQGT7uq3hc51kXa1gC%2Bgs%2F87rlkm1DC06IeUBjqzAlVp7PwR0VEoC51WK%2FhvG1fZRV0Y%2B7vVmlMvlubNZHe2A8p0UMIfpDLeXCwmZRlCjkeWyg4AB7WnPv0VHaQa1AVUHGfm4U1OfXFEhl5IH%2BfPmBBhc2v77qhajP1nxuHwjc1nLDppjiAXd%2Fn%2FWIvTp8AL50iQOWWGavRKdkax8Z%2FN9xVx%2BTZEp%2FV60n8QxYguURpQCesDP1mWdvh5MpZR7Dsz8K4ViZN104vk5LDCPDXiJLhBwkuKmnDi05YQq%2FqpiP0LEspol%2BHN8N2Wg9uscQBQDiY%2B%2Fr5RJZpkr4zyezj6t3ULaVLSHpzaWaaQ0lBimfxsxE42%2B52LA9Sot%2Be8b%2BYo7OQFZksUamzjKn%2BX6f1F3GgpwX650hCcFebB7na%2F2%2FI3yXdMWUuHozmg9oF%2FmUomjl4%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20220516T100752Z&X-Amz-SignedHeaders=host&X-Amz-Expires=300&X-Amz-Credential=ASIAWJYAKCGW4Q2FSZHJ%2F20220516%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Signature=231d56911dc2fde667377b5f28741bfb73cdb421d7d4204c5ce835e25e3fd5c0';
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
              SizedBox(
                height: 50,
              ),
              FutureBuilder(
                future: places.getDownloadUrl(2),
                builder: (BuildContext ctx, AsyncSnapshot snapshot) => Center(
                    child: CircleAvatar(
                  backgroundImage: NetworkImage(snapshot.data),
                  radius: 80,
                )),
              ),
              Text('Khaled'),
              SizedBox(
                height: 30,
              ),
              CustomSettingsButton(
                icon: Icons.edit,
                label: 'preferences',
                onTap: () async {
                  places.getComments(3);
                  
                },
              ),
              CustomSettingsButton(
                icon: Icons.history,
                label: 'history',
              ),
              CustomSettingsButton(
                icon: Icons.language,
                label: 'language',
              ),
              CustomSettingsButton(
                icon: Icons.admin_panel_settings,
                label: 'admin',
                onTap: () {
                  Navigator.of(context).pushNamed(AdminScreen.routeName);
                },
              ),
              TextButton(
                child: Text('sign out',
                    style: TextStyle(fontSize: 20, color: Colors.red[900])),
                onPressed: () async {
                  places.signout(context);
                },
              ),
            ],
          )),
    );
  }
}

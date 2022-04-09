import 'package:daleel/screens/settings_screen.dart';
import 'package:daleel/widgets/explore_widgets/category_detail_item.dart';
import 'package:flutter/material.dart';

class CircleWidget extends StatelessWidget {
  final String title;
  final Icon icon;
  CircleWidget(this.title, this.icon);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // double height = size.height;
    double width = size.width;
    return InkWell(
      onTap: (){
        Navigator.of(context).pushNamed(CategoryDetailItem.routeName);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            CircleAvatar(
              maxRadius: width/20,
              backgroundColor: Theme.of(context).primaryColor,
              child: icon,
            ),
            Container(
              // color: Colors.red,
              width: width/5.5,
              child: Center(
                child: Text(
                  title,
                  
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

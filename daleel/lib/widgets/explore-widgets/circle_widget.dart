import 'package:flutter/material.dart';

import 'package:daleel/widgets/explore-widgets/category_detail_item.dart';
import 'package:go_router/go_router.dart';

class CircleWidget extends StatelessWidget {
  final String title;
  final Icon icon;
  CircleWidget(this.title, this.icon);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return InkWell(
      onTap: (){
        GoRouter.of(context).go(CategoryDetailItem.routeName);
      },
      child: Column(
        children: [
          Container(
            height: height/10,
            width: width/10,
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF35A8E1), Color(0xFF40D8AB)]),
              shape: BoxShape.circle
            ),
            child: icon,
          ),
          Container(
            // color: Colors.red,
            width: width/5.5,
            child: Flexible(
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 12, color: Color(0xFF35A8E1)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:daleel/models/category.dart';
import 'package:daleel/providers/places.dart';
import 'package:daleel/shimmers/category_item_shimmer.dart';
import 'package:daleel/widgets/explore-widgets/circle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CategoryItems extends StatelessWidget {
  const CategoryItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const List<Icon> icons = [
      Icon(Icons.toys_outlined, color: Color(0xFF40D8AB),),
      Icon(Icons.park_outlined, color: Color(0xFF40D8AB)),
      Icon(Icons.monitor_heart, color: Color(0xFF40D8AB)),
      Icon(Icons.restaurant, color: Color(0xFF40D8AB)),
      Icon(Icons.coffee_outlined, color: Color(0xFF40D8AB)),
      Icon(Icons.shopping_bag_outlined, color: Color(0xFF40D8AB)),
      Icon(Icons.plumbing, color: Color(0xFF40D8AB)),
      Icon(Icons.phone_enabled_outlined, color: Color(0xFF40D8AB)),
    ];
    Places places = Provider.of<Places>(context, listen: false);
    return FutureBuilder(
      future: places.getCategories(),
      builder: ((BuildContext context,
              AsyncSnapshot<List<Category>> snapshot) =>
              snapshot.connectionState == ConnectionState.waiting ? CategoryItemShimmer() :
          StaggeredGridView.countBuilder(
              physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
              itemCount: 8,
              crossAxisCount: 4,
              staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
              itemBuilder: (BuildContext context, int index) => CircleWidget(
                  snapshot.data![index].category,
                  snapshot.data!.indexOf(snapshot.data![index]) == icons.indexOf(icons[index])
                      ? icons[index]
                      : Icon(Icons.add)))),
    );
  }
}

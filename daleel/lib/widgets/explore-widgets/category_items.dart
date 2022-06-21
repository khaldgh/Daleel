import 'package:daleel/models/category.dart';
import 'package:daleel/providers/places.dart';
import 'package:daleel/widgets/explore-widgets/circle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class CategoryItems extends StatelessWidget {
  const CategoryItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const List<Icon> icons = [
      Icon(Icons.toys),
      Icon(Icons.park),
      Icon(Icons.monitor_heart),
      Icon(Icons.restaurant),
      Icon(Icons.coffee),
      Icon(Icons.shopping_bag_outlined),
      Icon(Icons.plumbing),
      Icon(Icons.phone),
    ];
    Places places = Provider.of<Places>(context, listen: false);
    return FutureBuilder(
      future: places.getCategories(),
      builder: ((BuildContext context,
              AsyncSnapshot<List<Category>> snapshot) =>
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

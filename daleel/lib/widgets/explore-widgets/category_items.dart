import 'package:daleel/models/category.dart';
import 'package:daleel/providers/places.dart';
import 'package:daleel/shimmers/explore-shimmers/category_item_shimmer.dart';
import 'package:daleel/widgets/explore-widgets/circle_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CategoryItems extends StatefulWidget {
  const CategoryItems({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
    late Future<List<Category>> futureCategories;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Places places = Provider.of<Places>(context, listen: false);
    futureCategories = places.getCategories();
  }
  @override
  Widget build(BuildContext context) {
    const List<Icon> icons = [
      Icon(Icons.toys_outlined, color: Colors.white,),
      Icon(Icons.park_outlined, color: Colors.white),
      Icon(Icons.monitor_heart, color: Colors.white),
      Icon(Icons.restaurant, color: Colors.white),
      Icon(Icons.coffee_outlined, color: Colors.white),
      Icon(Icons.shopping_bag_outlined, color: Colors.white),
      Icon(Icons.plumbing, color: Colors.white),
      Icon(Icons.phone_enabled_outlined, color: Colors.white),
    ];
    
    return FutureBuilder(
      future: futureCategories ,
      builder: ((BuildContext context,
              AsyncSnapshot<List<Category>> snapshot) =>
              snapshot.connectionState == ConnectionState.waiting ? CategoryItemShimmer() :
              snapshot.hasError ? CategoryItemShimmer() :
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

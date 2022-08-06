
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class CategoryItemShimmer extends StatelessWidget {
  const CategoryItemShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // double height = size.height;
    double width = size.width;
    return Shimmer.fromColors(
          baseColor: Colors.grey[400]!,
          highlightColor: Colors.grey[200]!,
          child: StaggeredGridView.countBuilder(
            physics: NeverScrollableScrollPhysics(),
              itemCount: 8,
              crossAxisCount: 4,
              staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
              itemBuilder: (BuildContext context, int index) => Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: CircleAvatar(
                maxRadius: width/20,
                backgroundColor: Theme.of(context).primaryColor,
            ),
              ),));
  }
}
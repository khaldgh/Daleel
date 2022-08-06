import 'package:daleel/shimmers/explore-shimmers/dw_item.dart';
import 'package:daleel/shimmers/explore-shimmers/home-shimmers/home_item.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Shimmer.fromColors(
    //   baseColor: Colors.grey[400]!,
    //   highlightColor: Colors.grey[200]!,
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: [
    //       DWItem(),
    //       // DWItem(),
    //     ],
    //   ),
    // );
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemCount: 8,
      itemBuilder: (context, index) => Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[200]!,
      child: HomeItem(),
    ),
      staggeredTileBuilder: (index) => StaggeredTile.count(1, 1),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
    );
  }
}

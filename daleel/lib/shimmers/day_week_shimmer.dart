import 'package:daleel/shimmers/dw_item.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DayWeekShimmer extends StatelessWidget {
  const DayWeekShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[200]!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DWItem(),
          DWItem(),
        ],
      ),
    );
  }
}

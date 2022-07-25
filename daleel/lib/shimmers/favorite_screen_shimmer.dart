import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FavoriteScreenShimmer extends StatelessWidget {
  const FavoriteScreenShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[200]!,
      child: ListView.builder(
            itemCount: 4,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: ((context, i) => Container(
                    height: 300,
                    child: 
                    Card(
                      margin: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  )
                )),
          );
      }
}

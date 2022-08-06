import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shimmer/shimmer.dart';

class PlacesCollectionShimmer extends StatelessWidget {

  final bool hasError;
  final void Function(BuildContext context)? parentSnackbar;

  const PlacesCollectionShimmer(this.hasError, {this.parentSnackbar, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(hasError){
      parentSnackbar!(context);
    }
    
    return Shimmer.fromColors(
          baseColor: Colors.grey[400]!,
          highlightColor: Colors.grey[200]!,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 70,
                    width: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                ),
              ),
              Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 70,
                    width: 290,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
        );
  }
}
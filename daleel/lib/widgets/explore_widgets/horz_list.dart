import 'package:daleel/widgets/explore_widgets/single_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:daleel/providers/places.dart';
import 'package:daleel/providers/offers.dart';

class HorzList extends StatelessWidget {
  final bool? isWeekList;

  HorzList({this.isWeekList});
  @override
  Widget build(BuildContext context) {
    final placeProvider = Provider.of<Places>(context, listen: false);
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: placeProvider.favoritePlaces.length,
      itemBuilder: (ctx, i) => SingleListItem(
        image: placeProvider.favoritePlaces.reversed.toList()[i].images![0] ,
        title: placeProvider.favoritePlaces.reversed.toList()[i].title,
        category: placeProvider.favoritePlaces.reversed.toList()[i].category!.category ,
      ) ,
    );
  }
}
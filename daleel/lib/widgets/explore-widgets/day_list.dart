import 'package:daleel/widgets/explore-widgets/single_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:daleel/providers/places.dart';

class DayList extends StatelessWidget {
  final bool? isWeekList;

  DayList({this.isWeekList});
  @override
  Widget build(BuildContext context) {
    final places = Provider.of<Places>(context, listen: false);
    return FutureBuilder(
      future: places.getPlaces() ,
      builder: (BuildContext context, AsyncSnapshot snapshot) => ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data.length,
        itemBuilder: (ctx, i) => SingleListItem(
          image: snapshot.data[i].images![0] ,
          title: snapshot.data[i].title,
          category: snapshot.data[i].category!.category ,
        ) ,
      ),
    );
  }
}
import 'package:daleel/models/place.dart';
import 'package:daleel/shimmers/explore-shimmers/day_week_shimmer.dart';
import 'package:daleel/widgets/explore-widgets/single_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:daleel/providers/places.dart';

class WeekList extends StatefulWidget {
  final bool? isWeekList;

  WeekList({this.isWeekList});

  @override
  State<WeekList> createState() => _WeekListState();
}

class _WeekListState extends State<WeekList> {
  late Future<List<Place>> futurePlaces;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final places = Provider.of<Places>(context, listen: false);
    futurePlaces = places.getPlaces();
  }
  @override
  Widget build(BuildContext context) {
    final places = Provider.of<Places>(context, listen: false);
    return FutureBuilder(
      future: futurePlaces,
      builder: (BuildContext context, AsyncSnapshot snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? DayWeekShimmer()
              : snapshot.hasError ? DayWeekShimmer() : ListView.builder(
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
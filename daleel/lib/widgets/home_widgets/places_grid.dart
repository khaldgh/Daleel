import 'package:daleel/models/category.dart';
import 'package:daleel/models/place.dart';
import 'package:daleel/screens/details_screen.dart';
import 'package:daleel/widgets/home_widgets/filter_chip_widget.dart';
import 'package:daleel/widgets/explore_widgets/horz_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:daleel/widgets/home_widgets/image_card.dart';
import 'package:daleel/providers/places.dart';

class PlacesGrid extends StatefulWidget {
  static const routeName = '/places-grid';
  PlacesGrid({this.fetchDetails});
  final Function? fetchDetails;

  @override
  State<PlacesGrid> createState() => _PlacesGridState();
}

class _PlacesGridState extends State<PlacesGrid> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<Places>(context, listen: false).getPlaces();
    super.initState();
  }

  bool changeFlipWidget = false;
  @override
  Widget build(BuildContext context) {
    Future<List<Place>> places =
        Provider.of<Places>(context, listen: false).getPlaces();
    return FutureBuilder(
        future: places,
        builder: (BuildContext context, AsyncSnapshot<List<Place>> snapshot) {
          List<Place> places = snapshot.data ?? [];
          places.forEach((element) {
            print(element.category!.category);
          });
          List<String> labels =
              places.map((e) => e.category!.category!).toSet().toList();
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : snapshot.hasError
                  ? Center(child: Text(snapshot.error.toString()))
                  : SafeArea(
                      bottom: false,
                      child: Column(
                        children: [
                          Expanded(
                            child: FilterChipWidget(
                              count: labels.length,
                              label: labels,
                            ),
                            flex: 1,
                          ),
                          Container(
                            child: Expanded(
                              flex: 8,
                              child: StaggeredGridView.countBuilder(
                                crossAxisCount: 2,
                                itemCount: places.length,
                                itemBuilder: (context, index) => ImageCard(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        DetailsScreen.routeName,
                                        arguments: places[index].place_id);
                                    // print(count);
                                    print(places[index].place_id);
                                  },
                                  image: places[index].images![0],
                                  title: places[index].title,
                                  category: places[index].category!.category,
                                ),
                                staggeredTileBuilder: (index) =>
                                    StaggeredTile.fit(1),
                                mainAxisSpacing: 8.0,
                                crossAxisSpacing: 8.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
        });
  }
}

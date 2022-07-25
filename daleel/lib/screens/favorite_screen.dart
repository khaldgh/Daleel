import 'package:daleel/models/category.dart';
import 'package:daleel/models/neighborhood.dart';
import 'package:daleel/models/user.dart';
import 'package:daleel/screens/details_screen.dart';
import 'package:daleel/shimmers/favorite_screen_shimmer.dart';
import 'package:daleel/widgets/favorite-screen-widgets/favorite_slider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:carousel_indicator/carousel_indicator.dart';

import 'package:daleel/models/place.dart';
import 'package:daleel/providers/places.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    Places places = Provider.of<Places>(context, listen: false);
    Future<List<Place>>? futureFunc = places.getFavoritePlaces();
    return FutureBuilder(
        future: futureFunc,
        builder: (BuildContext context, AsyncSnapshot<List<Place>> snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? FavoriteScreenShimmer()
                : snapshot.hasError
                    ? Center(
                        child: Text(snapshot.error.toString()),
                      )
                    : snapshot.data!.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('''
        ترا فيه اماكن حلوه في التطبيق
 روح ابحث عنها و فضلها و بتطلع لك هنا
'''),
                                Icon(Icons.tag_faces_sharp)
                              ],
                            ),
                          )
                        : Center(
                            child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: ((context, i) => InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        DetailsScreen.routeName,
                                        arguments: snapshot.data![i].place_id);
                                  },
                                  child: Container(
                                    height: 300,
                                    child: Card(
                                      color: Colors.white70,
                                      margin: EdgeInsets.all(20),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      // shadowColor: Colors.black,
                                      elevation: 10,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          FavoriteSlider(
                                              places: snapshot.data, index: i),
                                          Divider(thickness: 1),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(snapshot
                                                  .data![i].category!.category),
                                              Text(snapshot.data![i].title!,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          )));
  }
}

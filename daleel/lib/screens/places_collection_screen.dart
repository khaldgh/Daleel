import 'package:daleel/models/place.dart';
import 'package:daleel/providers/places.dart';
import 'package:daleel/screens/details_screen.dart';
import 'package:daleel/widgets/explore-widgets/image_slider.dart';
import 'package:daleel/widgets/home-widgets/image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PlacesCollectionScreen extends StatefulWidget {
  static const routeName = '/place-collection';
  const PlacesCollectionScreen({Key? key}) : super(key: key);

  @override
  State<PlacesCollectionScreen> createState() => _PlacesCollectionScreenState();
}

class _PlacesCollectionScreenState extends State<PlacesCollectionScreen> {
  late Future<List<Place>> futurePlaces;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Places places = Provider.of<Places>(context, listen: false);
    futurePlaces = places.getPlaces();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Container(
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Card(
                  elevation: 3,
                  child: Container(
                      height: 370,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Image.asset('assets/images/ku_b-1-768x495.jpg',
                          //     alignment: Alignment.topCenter),
                          ImageSlider(),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 1.0 , left:8.0),
                                      child: Icon(
                                        Icons.location_on,
                                        size: 35,
                                        color: Colors.red[700],
                                      ),
                                    ),
                                    Text('اذهب')
                                  ],
                                ),
                                Text(
                                  'بافيليون الخبر',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                Text('تجمع مقاهي المنطقة الشرقية بمدينة الخبر'),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: futurePlaces,
              builder: (BuildContext context, AsyncSnapshot snapshot) =>
                  StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => ImageCard(
                  onTap: () {
                    GoRouter.of(context).go('${DetailsScreen.routeName}/${snapshot.data![index].place_id}');
                    // print(count);
                    // print(snapshot.data![index].place_id);
                    print(snapshot.data![index].images);
                  },
                  image: snapshot.data![index].images![0],
                  title: snapshot.data![index].title,
                  category: snapshot.data![index].category!.category,
                ),
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

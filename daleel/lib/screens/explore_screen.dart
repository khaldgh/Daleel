import 'package:daleel/widgets/explore-widgets/week_list.dart';
import 'package:daleel/widgets/places-collection/places_collection_widget.dart';
import 'package:daleel/widgets/explore-widgets/category_items.dart';
import 'package:daleel/widgets/explore-widgets/day_list.dart';
import 'package:daleel/widgets/explore-widgets/offers_list.dart';
import 'package:flutter/material.dart';

import '../widgets/explore-widgets/image_slider.dart';
import '../widgets/explore-widgets/search_bar.dart';

class ExploreScreen extends StatelessWidget {
  static const routeName = '/explore_screen';
  @override
  Widget build(BuildContext context) {
    // final places = Provider.of<Places>(context).favoritePlaces;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                ImageSlider(),
                SearchBar(),
                Container(
                  height: 90,
                  child: PlacesCollectionWidget(),
                ), // to use a listView.builder inside a column, the child's height of the listView should be smaller than the container height
                // Container(height: 90,child: CapitalPlaces(),),
                const SizedBox(),
                Container(
                  height: 170,
                  child: CategoryItems(),
                ),
                Column(
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     CircleWidget('events', const Icon(Icons.event)),
                    //     CircleWidget('restaurants', const Icon(Icons.restaurant)),
                    //     CircleWidget('real estate', const Icon(Icons.house)),
                    //     CircleWidget('cars', const Icon(Icons.directions_car)),
                    //   ],
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     CircleWidget(
                    //         'shopping', const Icon(Icons.shopping_bag_outlined)),
                    //     CircleWidget(
                    //         'business', const Icon(Icons.business_center)),
                    //     CircleWidget('art', const Icon(Icons.brush)),
                    //     CircleWidget(
                    //         'more', const Icon(Icons.more_horiz_outlined)),
                    //   ],
                    // ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 500,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: const Text(
                              'Most viewed today',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                              child:
                                  DayList()), // to use a listView.builder inside a column, the child's height of the listView should be smaller than the container height
                          const Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: const Text(
                              'Most viewed this week',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(child: WeekList()),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'Latest offers',
                        style:
                            TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: 700,
                      // color: Colors.blue,
                      child: OffersList(),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart' hide SearchBar;

import 'package:daleel/widgets/explore-widgets/week_list.dart';
import 'package:daleel/widgets/places-collection/places_collection_widget.dart';
import 'package:daleel/widgets/explore-widgets/category_items.dart';
import 'package:daleel/widgets/explore-widgets/day_list.dart';
import 'package:daleel/widgets/explore-widgets/offers_list.dart';
import '../widgets/explore-widgets/image_slider.dart';
import '../widgets/explore-widgets/search_bar.dart';

class ExploreScreen extends StatelessWidget {
  static const routeName = '/explore-screen';

void openSnackBar(BuildContext context){
  final snackBar = SnackBar(
            content: const Text('الرجاء التأكد من الاتصال بالانترنت'),
            behavior: SnackBarBehavior.floating ,
  );
  WidgetsBinding.instance.addPostFrameCallback((_) {
    
     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  });
  }
  

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
                // ImageSlider(),
                const SizedBox(
                  height: 40,
                ),
                SearchBar(),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 180,
                  child: CategoryItems(),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Container(height: 90,child: CapitalPlaces(),),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   children: [
                //     const Padding(
                //       padding: const EdgeInsets.only(right: 18.0, bottom: 8.0),
                //       child: const Text(
                //         'الاماكن المفتوحة',
                //         style: const TextStyle(
                //             fontSize: 20, fontWeight: FontWeight.bold),
                //       ),
                //     ),
                //     Container(
                //       height: 90,
                //       child: PlacesCollectionWidget(openSnackBar),
                //     ),
                //   ],
                // ), // to use a listView.builder inside a column, the child's height of the listView should be smaller than the container height
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 500,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Padding(
                            padding:
                                const EdgeInsets.only(right: 18.0, bottom: 8.0),
                            child: const Text(
                              'الاكثر زيارة اليوم',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                              child:
                                  DayList()), // to use a listView.builder inside a column, the child's height of the listView should be smaller than the container height
                          const Padding(
                            padding:
                                const EdgeInsets.only(right: 18.0, bottom: 8.0),
                            child: const Text(
                              'الاكثر زيارة هذا الاسبوع',
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
                        'احدث العروض',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: 600,
                      // color: Colors.blue,
                      child: OffersList(),
                    ),
                    // TextButton(child: Text('button'), onPressed: () => openSnackBar(context),)
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

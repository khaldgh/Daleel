import 'package:daleel/models/category.dart';
import 'package:daleel/providers/places.dart';
import 'package:daleel/screens/places_collection_screen.dart';
import 'package:daleel/screens/test_screen2.dart';
import 'package:daleel/shimmers/places_collection_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:shimmer/shimmer.dart';

class PlacesCollectionWidget extends StatefulWidget {
  static const routeName = '/capital-places';

  final void Function(BuildContext context) parentSnackbar;

  const PlacesCollectionWidget( this.parentSnackbar, {Key? key}) : super(key: key);

  @override
  State<PlacesCollectionWidget> createState() => _PlacesCollectionWidgetState();
}

class _PlacesCollectionWidgetState extends State<PlacesCollectionWidget> {

  late Future<List<Category>> getBigCategories;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Places places = Provider.of<Places>(context, listen: false);
    getBigCategories = places.getBigCategories();

  }

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
      future: getBigCategories,
      builder: (BuildContext context, AsyncSnapshot snapshot) =>
        snapshot.connectionState == ConnectionState.waiting ? PlacesCollectionShimmer(false, parentSnackbar: widget.parentSnackbar) : snapshot.hasError ? PlacesCollectionShimmer(true, parentSnackbar: widget.parentSnackbar,) :  ListView.builder(
        itemCount: snapshot.data.length,
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () => GoRouter.of(context)
                .go(TestScreen2.routeName),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/aramco.jpeg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.linearToSrgbGamma()
                    ),
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(12),
              ),
              height: 50,
              width: 290,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Center(
                  child: Text(
                    snapshot.data[index].category,
                    style: TextStyle(
                      // shadows: [Shadow(color: Colors.red, blurRadius: 0.9)],
                      fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

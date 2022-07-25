import 'package:daleel/providers/places.dart';
import 'package:daleel/screens/places_collection_screen.dart';
import 'package:daleel/shimmers/places_collection_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shimmer/shimmer.dart';

class PlacesCollectionWidget extends StatelessWidget {
  static const routeName = '/capital-places';

  final Function parnetSnackBar;

  const PlacesCollectionWidget( this.parnetSnackBar, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Places places = Provider.of<Places>(context, listen: false);
    return FutureBuilder(
      future: places.getBigCategories(),
      builder: (BuildContext context, AsyncSnapshot snapshot) =>
        snapshot.connectionState == ConnectionState.waiting ? PlacesCollectionShimmer(false) : snapshot.hasError ? PlacesCollectionShimmer(true, parnetSnackBar: parnetSnackBar,) :  ListView.builder(
        itemCount: snapshot.data.length,
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context)
                .pushNamed(PlacesCollectionScreen.routeName),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/collections/0d933113-fc3f-4a67-887e-1ba18cefb051.jpg'),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon(
                    //   Icons.category,
                    //   size: 35,
                    // ),
                    Text(
                      snapshot.data[index].category,
                      style: TextStyle(
                        // shadows: [Shadow(color: Colors.red, blurRadius: 0.9)],
                        fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

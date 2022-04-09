import 'package:daleel/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import 'package:daleel/providers/places.dart';
import 'package:daleel/widgets/home_widgets/image_card.dart';



class CategoryDetailItem extends StatefulWidget {
  static const routeName = '/category-detail-item';
  const CategoryDetailItem({Key? key}) : super(key: key);

  @override
  State<CategoryDetailItem> createState() => _CategoryDetailItemState();
}

class _CategoryDetailItemState extends State<CategoryDetailItem> {
  void initState() {
    // TODO: implement initState
     Provider.of<Places>(context, listen: false).getPlaces();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      // final places = Provider.of<Places>(context);
  Future<List<Place>> places = Provider.of<Places>(context, listen: false).getPlaces();

    return FutureBuilder(
      future: places,
      builder: (BuildContext context, AsyncSnapshot snapshot) => StaggeredGridView.countBuilder(
        crossAxisCount: 3,
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) => ImageCard(
          image: snapshot.data[index].imageUrl,
        ),
        staggeredTileBuilder: (index) => StaggeredTile.count(
            (index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
    );
  }
}



// class MapSample extends StatefulWidget {
//   @override
//   State<MapSample> createState() => MapSampleState();
// }

// class MapSampleState extends State<MapSample> {
//   Completer<GoogleMapController> _controller = Completer();

//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );

//   static final CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(37.43296265331129, -122.08832357078792),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: GoogleMap(
//         mapType: MapType.hybrid,
//         initialCameraPosition: _kGooglePlex,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: _goToTheLake,
//         label: Text('To the lake!'),
//         icon: Icon(Icons.directions_boat),
//       ),
//     );
//   }

//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//   }
// }
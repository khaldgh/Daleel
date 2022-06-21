
import 'package:daleel/models/comment.dart';
import 'package:daleel/widgets/details-widgets/comments_widget.dart';
import 'package:daleel/widgets/details-widgets/details_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

import '../providers/places.dart';

// you will be directed to this page if you clicked one of the items of the home screen

class DetailsScreen extends StatefulWidget {
  static const routeName = 'details-screen';

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool favorited = false;
  FlutterSecureStorage fss = FlutterSecureStorage();

  Future<void> favoriteButtonStatus() async {
    String? readValue = await fss.read(key: 'favorited');

    favorited = readValue!.toLowerCase() == 'true';
  }

  @override
  Widget build(BuildContext context) {
    final place = Provider.of<Places>(context);
    final int homeArgs = ModalRoute.of(context)!.settings.arguments as int;
    final fetchedProduct = place.findById(homeArgs);
    final Future<List<Comment>> getComments = place.getComments(homeArgs);
    var size = MediaQuery.of(context).size;

    favoriteButtonStatus();

    return FutureBuilder(
      future: Future.wait([fetchedProduct, getComments]),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) =>
          Scaffold(
        appBar: AppBar(
          title: Text(snapshot.data![0]!.title!),
          actions: [
            IconButton(
              icon: favorited
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_border),
              onPressed: () {
                setState(() {
                  favorited = !favorited;
                  fss.write(key: 'favorited', value: favorited.toString());
                  // place.addToFavorites(homeArgs);
                });
                favorited
                    ? place.userFavorite(homeArgs)
                    : place.removeFavorite(homeArgs);
              },
            ),
            IconButton(
              icon: Icon(Icons.chat),
              onPressed: () {
                // place.testRead();
              },
            )
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: Stack(clipBehavior: Clip.none, children: [
          Positioned(
            child: Container(
              alignment: Alignment.topCenter,
              height: 2300,
              child: Image.network(snapshot.data![0]!.images![0]),
            ),
          ),
          Positioned(
            top: 130.0,
            right: 0.0,
            left: 0.0,
            bottom: 0.0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: SingleChildScrollView(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      DetailsCard(
                        title: snapshot.data![0]!.title!,
                        description: snapshot.data![0]!.description!,
                        category: snapshot.data![0]!.category!,
                        images: snapshot.data![0]!.images!,
                        user: snapshot.data![0]!.user!,
                        weekdays: snapshot.data![0]!.weekdays!,
                      ),
                    ],
                  ),
                ),
                height: 1900,
                width: double.infinity,
              ),
            ),
          ),
          CommentsWidget(futureFunc: snapshot.data![1], id: homeArgs),
        ]),
      ),
    );
  }
}

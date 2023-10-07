import 'package:daleel/models/category.dart';
import 'package:daleel/models/comment.dart';
import 'package:daleel/models/neighborhood.dart';
import 'package:daleel/models/place.dart';
import 'package:daleel/models/user.dart';
import 'package:daleel/widgets/details-widgets/comments_widget.dart';
import 'package:daleel/widgets/details-widgets/details_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/places.dart';

// you will be directed to this page if you clicked one of the items of the home screen

class DetailsScreen extends StatefulWidget {
  DetailsScreen({this.arguments, Key? key}) : super(key: key);
  static const routeName = '/details-screen';
  int? arguments;

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool favorited = false;
  FlutterSecureStorage fss = FlutterSecureStorage();
  int homeArgs = 0;
  String? readValue = '';
  late Future<List<dynamic>> futures;
  late Future<Place> fetchedPlace;
  late Future<List<Place>>? favorites;
  late Future<List<Comment>> getComments;
  late Places place;

  Future<void> favoriteButtonStatus(int id) async {
    List<Place>? awaitedFavorites = await favorites ?? [];
    bool favoritesContainsCurrentPlace = awaitedFavorites.contains(awaitedFavorites.firstWhere((place) => place.place_id == id, orElse: () => Place()));
    bool test = favoritesContainsCurrentPlace;
    print(test);
    favorited = test;
    // readValue = await fss.read(key: id.toString());
    // print(readValue);
    // favorited = readValue!.toLowerCase() == id.toString();
    // print(favorited);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeArgs = widget.arguments!;
     place = Provider.of<Places>(context, listen: false);
     favorites = place.getFavoritePlaces();  
     fetchedPlace = place.findById(homeArgs);
     getComments = place.getComments(homeArgs);
    futures = Future.wait([fetchedPlace, getComments]);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    favoriteButtonStatus(homeArgs);

    return FutureBuilder(
        future: futures,
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          var snapsht = snapshot.data ??
              [
                Place(
                    title: '',
                    category: Category(),
                    description: '',
                    weekdays: [],
                    approved: true,
                    images: [''],
                    instagram: '',
                    neighborhoods: [Neighborhood()],
                    phone: 0,
                    user: User(
                        user_id: 2, email: '', username: '', profilePic: ''),
                    website: ''),
                [Comment()]
              ];

          return snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: Scaffold(body: Center(child: CircularProgressIndicator())),
                )
              : Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: AppBar(
                    actions: [
                      IconButton(
                        icon: favorited
                            ? Icon(Icons.favorite)
                            : Icon(Icons.favorite_border),
                        onPressed: () {
                          // var favorited = fss.read(key: 'favorited');
                          setState(() {
                            favorited = !favorited;
                            // fss.write(
                            //     key: 'favorited', value: snapsht[0].place_id.toString());
                            // place.addToFavorites(homeArgs);
                          });
                          favorited
                              ? place.userFavorite(homeArgs)
                              : place.removeFavorite(homeArgs);
                        },
                      ),
                      // IconButton(onPressed: (){
                      //   GoRouter.of(context).pop();
                      // }, icon: Icon(Icons.arrow_back))
                    ],
                  ),
                  // backgroundColor: Theme.of(context).primaryColor,
                  body:
                      // snapshot.connectionState == ConnectionState.waiting
                      //     ?
                      //     Center(
                      //         child: CircularProgressIndicator(
                      //         color: Colors.red,
                      //       ))
                      //     :
                      Stack(clipBehavior: Clip.none, children: [
                    Container(
                      alignment: Alignment.topCenter,
                      height: 2300,
                      child: Image.network(snapsht[0].images![0]),
                    ),
                    Positioned(
                      top: 130.0,
                      right: 0.0,
                      left: 0.0,
                      bottom: 0.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: SingleChildScrollView(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: DetailsCard(
                                  title: snapsht[0].title!,
                                  description: snapsht[0].description!,
                                  category: snapsht[0].category!,
                                  images: snapsht[0].images!,
                                  user: snapsht[0].user!,
                                  weekdays: snapsht[0].weekdays!,
                            ),
                          ),
                          height: 1900,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    // CommentsWidget(futureFunc: snapsht[1], id: homeArgs),
                  ]),
                );
        });
  }
}

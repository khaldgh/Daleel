import 'dart:convert';

import 'package:daleel/widgets/details-widgets/details_card.dart';
import 'package:daleel/widgets/details-widgets/image_viewer.dart';
import 'package:daleel/widgets/explore_widgets/image_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/places.dart';

// you will be directed to this page if you clicked one of the items of the home screen

class DetailsScreen extends StatefulWidget {
  static const routeName = 'details-screen';

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var favorited = false;
  @override
  Widget build(BuildContext context) {
    final place = Provider.of<Places>(context);
    final int homeArgs 
    = ModalRoute.of(context)!.settings.arguments as int;
    final fetchedProduct = place.findById(homeArgs);
    return  FutureBuilder(
      future: fetchedProduct,
      builder: (BuildContext context, AsyncSnapshot snapshot) => Scaffold(
          appBar: AppBar(
            title: Text(snapshot.data.title!),
            actions: [
              IconButton(
                icon:
                    favorited ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
                onPressed: () {
                  setState(() {
                    favorited = !favorited;
                    // place.addToFavorites(homeArgs);
                  });
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
          body: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                child: Container(
                  alignment: Alignment.topCenter,
                  height: 2300,
                  child: Image.network(snapshot.data.images![0]['image']),
                ),
              ),
              Positioned(
                top: 130.0,
                right: 0.0,
                left: 0.0,
                bottom: 0.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: SingleChildScrollView(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          // ImageViewer(),
                          SizedBox(
                            height: 20,
                          ),
                          DetailsCard(
                            title: snapshot.data.title!,
                            description: snapshot.data.description!,
                            category: snapshot.data.category!,
                            images: snapshot.data.images!,
                            weekdays: snapshot.data.weekdays!,
                          )
                        ],
                      ),
                    ),
                    height: 1900,
                    width: double.infinity,
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }
}

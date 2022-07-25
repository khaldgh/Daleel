import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:daleel/providers/places.dart';
import 'package:daleel/widgets/details-widgets/details_card.dart';


// You will be directed to this page if you used the Search bar from the Explore screen

class SearchDetailsScreen extends StatefulWidget {
  static const routeName = '/search-details-screen';

  @override
  _SearchDetailsScreenState createState() => _SearchDetailsScreenState();
}

class _SearchDetailsScreenState extends State<SearchDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final searchArgs = ModalRoute.of(context)?.settings.arguments as int;
    final fetchedProductByTitle = Provider.of<Places>(context).findById(searchArgs);
    return FutureBuilder(
      future: fetchedProductByTitle,
      builder: (BuildContext context, AsyncSnapshot snapshot) => 
      Scaffold(
        appBar: AppBar(
          title: Text(snapshot.data.title!),
          actions: [
            IconButton(icon: Icon(Icons.favorite_border), onPressed: (){}),
            IconButton(icon: Icon(Icons.chat), onPressed: (){})
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
                child: Image.network((snapshot.data.images![0])),
              ),
            ),
            Positioned(
              top: 130.0,
              right: 10.0,
              left: 10.0,
              bottom: 0.0,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
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
                          category: snapshot.data.category!,
                          title: snapshot.data.title!,
                          description: snapshot.data.description!,
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

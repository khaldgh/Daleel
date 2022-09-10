import 'package:daleel/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:daleel/providers/places.dart';
import 'package:daleel/models/place.dart';


// futureBuilder needs to be rewritten, the future needs to go to initState


class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final places = Provider.of<Places>(context, listen: false);
    return FutureBuilder(
      future: places.getPlaces(),
      builder: ( BuildContext contxt, AsyncSnapshot snapshot) => Container(
        height: 57,
        width: 390,
        margin: EdgeInsets.only(top: 10, bottom: 10, right: 25, left: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)]
            ),
        child: Container(
          height: 50,
          width: 360,
          margin: EdgeInsets.all(9),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            // color: Colors.grey[350],
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: [
              Expanded(
                  child: TypeAheadField<Place>(
                textFieldConfiguration: TextFieldConfiguration(
                  decoration: InputDecoration(
                    border: InputBorder.none
                  ),
                  textDirection: TextDirection.rtl,
                  // decoration: InputDecoration(tex)
                    // autofocus: true,
                    ),
                onSuggestionSelected: (suggestion) {
                  Navigator.of(context).pushNamed(DetailsScreen.routeName,
                      arguments: suggestion.place_id);
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      backgroundImage: NetworkImage(suggestion.images![0]),
                    ),
                    title: RichText(
                      text: TextSpan(
                          text: suggestion.title,
                          style: TextStyle(color: Colors.black)),
                    ),
                  );
                },
                suggestionsCallback: (pattern) {
                  return pattern.isEmpty
                      ? snapshot.data
                      : places.searchPlaces(pattern);
                      // snapshot.data.where((place) {
                      //     final placeLower = place.title!.toLowerCase();
                      //     final patternLower = pattern.toLowerCase();
    
                      //     return placeLower.contains(patternLower);
                      //   }).toList();
                },
              )
              ),
              // VerticalDivider(
              //   color: Colors.grey,
              //   thickness: 1,
              // ),
              SizedBox(
                width: 10,
              ),
              Icon(Icons.search),
              
              
              // Expanded(
              //   child: TextField(
              //     controller: searchController ,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

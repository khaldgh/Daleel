import 'package:daleel/models/city.dart';
import 'package:daleel/providers/places.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// https://medium.flutterdevs.com/chip-widgets-in-flutter-7a2d3d34597c
// choice chip reference

class CityChip extends StatefulWidget {
  CityChip(
      {Key? key,
      this.categorySelected,
      @required this.title,
      @required this.futureFunction})
      : super(key: key);
  final String? title;
  final Function? categorySelected;
  final Future<List<Object>>? futureFunction;

  @override
  State<CityChip> createState() => _CityChipState();
}

class _CityChipState extends State<CityChip> {
  City choiceIndex = City();
  bool noSelection = true;
  @override
  Widget build(BuildContext context) {
    Places places = Provider.of<Places>(context);
    return FutureBuilder(
      future: widget.futureFunction,
      builder: (BuildContext context, AsyncSnapshot snapshot) =>
          Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(
              right: 15.0,
              top: 15.0,
            ),
            child: Text(widget.title!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          ),
          Wrap(
              // you can try GridView.builder in the future if Wrap doesn't satisfy your needs here
              alignment: WrapAlignment.end,
              children: snapshot.data!.map<Widget>((City choice) { 
                return Padding(
                  padding: const EdgeInsets.only(
                    right: 2.0,
                  ),
                  child: ChoiceChip(
                      label: Text(choice.city!),
                      selectedColor: Colors.blue,
                      selected: noSelection
                          ? choice == snapshot.data!.reversed.toList()[0]
                          : choice == choiceIndex,
                      onSelected: (bool isSelected) {
                        setState(() {
                          noSelection = false;
                          choiceIndex = isSelected ? choice : City();
                            places.neighborhoodQuery(choiceIndex.cityId!);
                        });
                      }),
                );
              }).toList()),
        ],
      ),
    );
  }
}

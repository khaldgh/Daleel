import 'package:daleel/models/neighborhood.dart';
import 'package:daleel/models/place.dart';
import 'package:daleel/providers/places.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// https://medium.flutterdevs.com/chip-widgets-in-flutter-7a2d3d34597c
// choice chip reference

class NeighborhoodChip extends StatefulWidget {
  NeighborhoodChip({
    Key? key,
    this.addValue,
  }) : super(key: key);
  final Function? addValue;

  @override
  State<NeighborhoodChip> createState() => _NeighborhoodChipState();
}

class _NeighborhoodChipState extends State<NeighborhoodChip> {
  Neighborhood choiceIndex = Neighborhood();
  @override
  Widget build(BuildContext context) {
    Places places = Provider.of<Places>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(
            right: 15.0,
            top: 15.0,
          ),
          child: Text('الحي',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
        ),
        Wrap(
            // you can try GridView.builder in the future if Wrap doesn't satisfy your needs here
            alignment: WrapAlignment.end,
            children: places.neighborhoods!.map<Widget>((Neighborhood neighborhood) {
              return Padding(
                padding: const EdgeInsets.only(
                  right: 2.0,
                ),
                child: ChoiceChip(
                    label: Text(neighborhood.neighborhood!),
                    selectedColor: Colors.blue,
                    selected: choiceIndex == neighborhood,
                    onSelected: (bool isSelected) {
                      setState(() {
                        choiceIndex = isSelected ? neighborhood : Neighborhood();
                      });
                      widget.addValue!(
                        choiceIndex
                      );
                    }),
              );
            }).toList()),
      ],
    );
  }
}

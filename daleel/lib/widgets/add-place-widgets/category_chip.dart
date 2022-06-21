import 'package:daleel/models/category.dart';
import 'package:daleel/models/place.dart';
import 'package:daleel/providers/places.dart';
import 'package:daleel/widgets/add-place-widgets/neighborhood_chip.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// https://medium.flutterdevs.com/chip-widgets-in-flutter-7a2d3d34597c
// choice chip reference

class CategoryChip extends StatefulWidget {
  CategoryChip(
      {Key? key,
      this.categorySelected,
      @required this.title,
      this.isCityChip = false,
      this.place,
      this.addValue,
      @required this.futureFunction})
      : super(key: key);
  final String? title;
  final bool? isCityChip;
  final Function? categorySelected;
  final Future<List<Object>>? futureFunction;
  final Place? place;
  final Function? addValue;
  

  @override
  State<CategoryChip> createState() => _CategoryChipState();
}

class _CategoryChipState extends State<CategoryChip> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Places>(context, listen: false).getCategories();
  }

  Category choiceIndex = Category();
  bool noSelection = true;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.futureFunction,
      builder: (BuildContext context, AsyncSnapshot snapshot) => Column(
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
              children: snapshot.data!.map<Widget>((Category choice) { 
                return Padding(
                  padding: const EdgeInsets.only(
                  right: 2.0,
                  ),
                  child: ChoiceChip(
                    label: Text(choice.category),
                    selectedColor: Colors.blue,
                    selected: noSelection
                        ? choice == snapshot.data!.reversed.toList()[0]
                        : choice == choiceIndex,
                    onSelected: (bool isSelected) {
                      setState(() {
                        noSelection = false;
                        choiceIndex = isSelected ? choice : Category();
                      });
                        widget.addValue!(choiceIndex);
                    }),
                );
              }).toList()),
        ],
      ),
    );
  }
}

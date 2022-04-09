import 'package:daleel/providers/places.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChipWidget extends StatefulWidget {
  
  final String? label;
  const ChipWidget(this.label,{ Key? key }) : super(key: key,);

  @override
  
  _ChipWidgetState createState() => _ChipWidgetState();
}


class _ChipWidgetState extends State<ChipWidget> {
  bool _selected = false;
  @override
  Widget build(BuildContext context) {
  Places places = Provider.of<Places>(context, listen: false);
  List<String> userPreferences = places.userPreferences;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: FilterChip(
            backgroundColor: Colors.grey[300],
            padding: EdgeInsets.all(10),
            selected: _selected,
            label: Text(widget.label!, style: TextStyle(fontSize: 15),),
            onSelected: (bool change) {
              setState(() {
                _selected = !_selected;
              });
              if(_selected){
                userPreferences.add(widget.label!);
              } else {
                userPreferences.remove(widget.label!);
              }
              print(userPreferences);
            },
            selectedColor: Colors.blue,
            showCheckmark: false,
          ),
    );
  }
}
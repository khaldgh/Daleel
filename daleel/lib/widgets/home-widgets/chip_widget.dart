import 'package:daleel/models/category.dart';
import 'package:daleel/providers/places.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChipWidget extends StatefulWidget {
  
  final Category? category;
  final List<Category>? categoriesList;
  const ChipWidget(this.category, this.categoriesList,{ Key? key }) : super(key: key,);

  @override
  
  _ChipWidgetState createState() => _ChipWidgetState();
}


class _ChipWidgetState extends State<ChipWidget> {
  bool _selected = false;
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: FilterChip(
            backgroundColor: Colors.grey[300],
            padding: EdgeInsets.all(10),
            selected: _selected,
            label: Text(widget.category!.category!, style: TextStyle(fontSize: 15),),
            onSelected: (bool change) {
              setState(() {
                _selected = !_selected;
              });
              if(_selected){
                widget.categoriesList!.add(widget.category!);
              } else {
                widget.categoriesList!.remove(widget.category!);
              }
              
            },
            selectedColor: Colors.blue,
            showCheckmark: false,
          ),
    );
  }
}
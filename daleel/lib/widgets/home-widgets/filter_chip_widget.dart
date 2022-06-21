import 'package:daleel/models/category.dart';
import 'package:flutter/material.dart';

class FilterChipWidget extends StatefulWidget {
  static const routeName = 'FilterChipWidget';
    FilterChipWidget({ this.count, this.labels, Key? key }) : super(key: key);

  final int? count;
  final List<String>? labels;

  @override
  State<FilterChipWidget> createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  bool _selected = false;
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.count,
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.all(5.5),
          child: FilterChip(showCheckmark: false,
          padding: EdgeInsets.all(5),
            selected: index == selectedIndex ? _selected : false,
            label: Text(widget.labels![index]),
            selectedColor: Colors.blue,
            onSelected: (changeFilterChip){ 
              setState(() {
                _selected = changeFilterChip;
                selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
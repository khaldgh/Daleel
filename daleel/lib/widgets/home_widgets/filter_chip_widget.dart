import 'package:daleel/models/category.dart';
import 'package:flutter/material.dart';

class FilterChipWidget extends StatefulWidget {
  static const routeName = 'FilterChipWidget';
    FilterChipWidget({ this.count, this.label, this.changeFilterChip, Key? key }) : super(key: key);

  final int? count;
  final List<String>? label;
  final bool? changeFilterChip;

  @override
  State<FilterChipWidget> createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  bool _selected = false;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.count,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsets.all(3.5),
        child: FilterChip(showCheckmark: false,
        padding: EdgeInsets.all(5),
          selected: _selected,
          label: Text(widget.label![index]),
          selectedColor: Colors.blue,
          onSelected: (changeFilterChip){ 
            setState(() {
              _selected = !_selected;
            });
          },
        ),
      ),
    );
  }
}
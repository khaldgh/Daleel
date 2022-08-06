import 'package:daleel/models/category.dart';
import 'package:flutter/material.dart';

class FilterChipWidget extends StatefulWidget {
  static const routeName = 'FilterChipWidget';
    FilterChipWidget({this.categories, this.fccFunction, Key? key }) : super(key: key);

  final List<Category?>? categories;
  final Function? fccFunction;

  @override
  State<FilterChipWidget> createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  bool _selected = false;
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<String> categoriesLabels = widget.categories!.map((e) => e!.category).toList();
    List<String> uniqueLabels = categoriesLabels.toSet().toList();
    return ListView.builder(
      itemCount: uniqueLabels.length,
      scrollDirection: Axis.horizontal,
      reverse: true,
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsets.all(5.5),
        child: FilterChip(showCheckmark: false,
        padding: EdgeInsets.all(5),
          selected: index == selectedIndex ? _selected : false,
          label: Text(uniqueLabels[index]),
          selectedColor: Colors.blue,
          onSelected: (changeFilterChip){ 
            setState(() {
              _selected = changeFilterChip;
              selectedIndex = index;
              widget.fccFunction!([widget.categories![index]]);
            });
          },
        ),
      ),
    );
  }
}
import 'package:daleel/models/category.dart';
import 'package:daleel/providers/places.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsChipWidget extends StatefulWidget {
  Category? category;
  List<Category>? selectedPrefs;
  SettingsChipWidget(this.category, this.selectedPrefs, 
      {Key? key})
      : super(
          key: key,
        );

  @override
  _SettingsChipWidgetState createState() => _SettingsChipWidgetState();
}

class _SettingsChipWidgetState extends State<SettingsChipWidget> {
  bool _selected = false;

  int removedId = 0;

  @override
  Widget build(BuildContext context) {

    List<int?> idList = widget.selectedPrefs!.map(((category) {
      if (category.categoryId == widget.category!.categoryId) {
        return category.categoryId;
      }
    })).toList();


    idList.remove(removedId);

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: FilterChip(
        backgroundColor: Colors.grey[300],
        padding: EdgeInsets.all(10),
        selected:
            idList.contains(widget.category!.categoryId) ? true : _selected,
        label: Text(
          widget.category!.category,
          style: TextStyle(fontSize: 15),
        ),
        onSelected: (bool change) {
          setState(() {
            if (idList.contains(widget.category!.categoryId)) {
              _selected = !_selected;
            }

            _selected = !_selected;
            removedId = widget.category!.categoryId;
            print('${widget.category!.toJson()} ${_selected}');
          });
          if (_selected) {
            widget.selectedPrefs!.add(widget.category!);
          } else {
            widget.selectedPrefs!.removeWhere(((element) => element.categoryId == widget.category!.categoryId));
          }
        },
        selectedColor: Colors.blue,
        showCheckmark: false,
      ),
    );
  }
}

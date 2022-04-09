import 'package:flutter/material.dart';

// https://medium.com/flutter-community/flutter-widget-in-focus-togglebuttons-know-it-all-b0f0c23f4518
// ToggleButtons reference 

class SubCategoryWidget extends StatefulWidget {
  const SubCategoryWidget({ Key? key }) : super(key: key);

  @override
  _SubCategoryWidgetState createState() => _SubCategoryWidgetState();
}

class _SubCategoryWidgetState extends State<SubCategoryWidget> {
  List<bool> boolList = [false, false, false, true,];
  List<String> subRests = ["فلافل", "مشاوي", "خفايف", "مقالي"];

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
                  children: subRests.reversed.map((sub) {
                      return Column(
                      children: [Icon(Icons.favorite), Text(sub)],
                    );
                    },).toList(),
                  isSelected: boolList,
                  onPressed: (int index) {
                    setState(() {
                      boolList[index] = !boolList[index];
                    });
                  },
                  renderBorder: true,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                );
  }
}
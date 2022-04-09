import 'package:daleel/models/category.dart';
import 'package:daleel/models/place.dart';
import 'package:daleel/providers/places.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminDropButton extends StatefulWidget {
  AdminDropButton({this.boldText, this.dDBChoice, Key? key}) : super(key: key);
  final String? boldText;
  final String? dDBChoice;
  @override
  _AdminDropButtonState createState() => _AdminDropButtonState();
}

class _AdminDropButtonState extends State<AdminDropButton> {
  List<String> cities = ['الدمام', 'الظهران', 'الخبر', 'الجبيل'];
  Place place = Place(title: '', description: '', category: Category(), images: []);
  // String? dropdownvalue = '';
  bool? isInit = true;
  @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   List<Place> formPlaces = Provider.of<Places>(context).formPlaces;
  //   String? dropdownvalue = formPlaces[0].category;
  //   isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    List<Place> formPlaces = Provider.of<Places>(context).formPlaces;
    String? dropdownvalue = formPlaces[0].category!.category;
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(widget.boldText!,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          DropdownButton(
              value: dropdownvalue,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: cities
                  .map((String item) => DropdownMenuItem(
                        value: item,
                        child: Text('${item}'),
                      ))
                  .toList(),
              onChanged: (String? newValue) {
                setState(() {

                  dropdownvalue = newValue!;
                });
              }),
        ],
      ),
    );
  }
}

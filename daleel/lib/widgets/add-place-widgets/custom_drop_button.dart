// import 'package:daleel/models/place.dart';
// import 'package:daleel/providers/places.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class CustomDropButton extends StatefulWidget {
//   CustomDropButton({this.boldText, this.dDBChoice, this.place, Key? key})
//       : super(key: key);
//   final String? boldText;
//   final String? dDBChoice;
//   final Place? place;
//   @override
//   _CustomDropButtonState createState() => _CustomDropButtonState();
// }

// class _CustomDropButtonState extends State<CustomDropButton> {
//   String dropdownvalue = 'الخبر';
//   Place place = Place(title: '', description: '', category: '');

//   @override
//   Widget build(BuildContext context) {
//     List<String> cities = Provider.of<Places>(context, listen: false).cities;
//     //  dropdownvalue = cities[0];
//     return Container(
//       margin: EdgeInsets.only(right: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Text(widget.boldText!,
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
//           DropdownButton(
//               value: dropdownvalue,
//               icon: const Icon(Icons.keyboard_arrow_down),
//               items: cities
//                   .map((String item) => DropdownMenuItem(
//                         value: item,
//                         child: Text('${item}'),
//                       ))
//                   .toList(),
//               onChanged: (String? newValue) {
//                 setState(() {
//                   dropdownvalue = newValue!;
//                   widget.place!.category = dropdownvalue;

//                   // Place userPlace =
//                   //     Provider.of<Places>(context, listen: false).userPlace;
//                   // userPlace.category = newValue;
//                 });
//               }),
//         ],
//       ),
//     );
//   }
// }

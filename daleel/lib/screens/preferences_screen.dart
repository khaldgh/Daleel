import 'package:daleel/models/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/home_widgets/chip_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../providers/places.dart';

class PrefrencesScreen extends StatefulWidget {
  static const routeName = 'prefrencesScreen';
  const PrefrencesScreen({Key? key}) : super(key: key);

  @override
  _PrefrencesScreenState createState() => _PrefrencesScreenState();
}

class _PrefrencesScreenState extends State<PrefrencesScreen> {
  var _selected = false;
  @override
  Widget build(BuildContext context) {
    Places places = Provider.of<Places>(context);
    List<String> nameList = Provider.of<Places>(context).nameList;

    return Scaffold(
        backgroundColor: Colors.blue[200],
        body: FutureBuilder(
          future: places.getCategories(),
          builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot) => Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/ku_b-1-768x495.jpg'),
                    opacity: 0.6,
                    fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 35.0),
                  child: Text(
                    ':اختر الاماكن المفضلة لديك',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Wrap(
                    children: [for (var i in snapshot.data!) ChipWidget(i.category)],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

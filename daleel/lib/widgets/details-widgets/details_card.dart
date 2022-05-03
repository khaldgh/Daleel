import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:daleel/models/category.dart';
import 'package:daleel/widgets/details-widgets/rating.dart';
import 'package:daleel/widgets/details-widgets/working_hours_card.dart';
import 'package:daleel/widgets/explore_widgets/horz_list.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DetailsCard extends StatefulWidget {
  DetailsCard(
      {this.category,
      this.title,
      this.description,
      this.weekdays,
      this.images});
  final String? title;
  final Category? category;
  final String? description;
  final List<String>? weekdays;
  final List<dynamic>? images;
  @override
  _DetailsCardState createState() => _DetailsCardState();
}

class _DetailsCardState extends State<DetailsCard> {
  var expand = false;

  // late bool isArabic;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   initializeDateFormatting('ar_SA', null);
  //   isArabic = true;
  // }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    String date = DateFormat.EEEE('ar_SA').format(DateTime.now());
    int weekdayIndex = DateTime.now().weekday;
    return Container(
      height: 1006,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
              ),
              items: widget.images!.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Image.network(i['image']));
                  },
                );
              }).toList(),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8),
                    child: Text(
                      widget.category!.category!,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 35,
                          color: Colors.deepOrange,
                        ),
                        Text(
                          'Go to location',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Column(
              children: [
                Text(
                  'Description',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Card(
                  shadowColor: Colors.orange,
                  elevation: 8,
                  child: Container(
                    width: 300,
                    height: 100,
                    margin: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Theme.of(context).primaryColor,
                    )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Text(widget.description!)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 8.0, bottom: 10.0),
                          child: Text(
                            'Working Hours                            ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 1, left: 15),
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              ),
                              height: expand ? 296 : 64,
                              width: 189,
                              child: Card(
                                elevation: 7,
                                child: Column(
                                  children: [
                                    !expand
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                //weekdayIndex == 1, 2, 3, 4, 5, 6, 7 starts with Monday
                                                // weekdays == 0, 1, 2 ,3, 4, 5, 6 starts with Sunday
                                                Text(weekdayIndex != 7
                                                    ? widget.weekdays!
                                                        .firstWhere((element) =>
                                                            widget.weekdays!
                                                                .indexOf(
                                                                    element) ==
                                                            weekdayIndex)
                                                    : widget.weekdays![0]),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(date),
                                              ],
                                            ),
                                          )
                                        : Expanded(
                                            child: WorkingHoursCard(
                                                widget.weekdays),
                                          )
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 30,
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(right: 15),
                                  child: IconButton(
                                    icon: Icon(
                                      expand
                                          ? Icons.expand_less_outlined
                                          : Icons.expand_more_outlined,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        expand = !expand;
                                      });
                                    },
                                  ),
                                ),
                                Column(
                                  children: [Text('Rating'), Rating()],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                    child: Text(
                      'Related places',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  height: 300,
                  child: HorzList(
                    isWeekList: false,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

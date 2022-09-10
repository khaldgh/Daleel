import 'package:flutter/material.dart';

import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:daleel/models/user.dart';
import 'package:daleel/widgets/details-widgets/full-screen-widget.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:daleel/models/category.dart';
import 'package:daleel/widgets/details-widgets/rating.dart';
import 'package:daleel/widgets/details-widgets/working_hours_card.dart';
import 'package:daleel/widgets/explore-widgets/day_list.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsCard extends StatefulWidget {
  DetailsCard(
      {this.category,
      this.title,
      this.description,
      this.weekdays,
      this.user,
      this.images});
  final String? title;
  final Category? category;
  final String? description;
  final List<String>? weekdays;
  final List<dynamic>? images;
  final User? user;
  @override
  _DetailsCardState createState() => _DetailsCardState();
}

class _DetailsCardState extends State<DetailsCard> {
  var expand = false;

  int _imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var getScreenHeight = MediaQuery.of(context).size.height / 2.5;
    initializeDateFormatting();
    String date = DateFormat.EEEE('ar_SA').format(DateTime.now());
    int weekdayIndex = DateTime.now().weekday;
    return Column(
      children: [
        Container(
          height: 1155,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FullScreenWidget(
                            images: widget.images, imageIndex: _imageIndex)));
                  },
                  child: CarouselSlider(
                      options: CarouselOptions(
                        viewportFraction: 0.9,
                        height: 300.0,
                        onPageChanged:
                            (int index, CarouselPageChangedReason reason) {
                          setState(() {
                            _imageIndex = index;
                          });
                        },
                      ),
                      items: widget.images!.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                // color: Colors.black,
                                width: MediaQuery.of(context).size.width,
                                // margin: EdgeInsets.symmetric(horizontal: 5.0),
                                child: Image.network(
                                  i,
                                  fit: BoxFit.fill,
                                ));
                          },
                        );
                      }).toList(),
                    ),
                ),
                SizedBox(
                  height: 15,
                ),
                CarouselIndicator(
                  activeColor: Colors.white54,
                  color: Colors.blue,
                  count: widget.images!.length,
                  index: _imageIndex,
                  height: 10,
                  width: 10,
                  space: 15,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.title!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      Text(
                        widget.category!.category,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 15,
                        ),
                      ),
                      Rating(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: Column(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.location_on,
                                size: 35,
                                color: Colors.deepOrange,
                              ),
                              onPressed: () {
                                Future<void> openMap(
                                    double latitude, double longitude) async {
                                  String googleUrl =
                                      'geo: 0, 0, 15z?q=8100 شارع عمر بن الخطاب، حي الفيصلية، الدمام 32272 4096،, Bufeyat+Omar';
                                  if (!await launchUrl(Uri.parse(googleUrl)))
                                    throw 'Could not open the map.';
                                }

                                openMap(26.4062189, 50.071216);

                                // launchUrl(Uri.parse(
                                //     'https://goo.gl/maps/SvVF5BseigVyRHwNA'));
                                // print('object');
                              },
                            ),
                            Text(
                              'اذهب',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.language),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: ShaderMask(
                                  shaderCallback: ((Rect bounds) {
                                    return LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: <Color>[
                                        Color(0xff515BD4),
                                        Color(0xff8134AF),
                                        Color(0xffDD2A7B),
                                        Color(
                                          0XFFF58529,
                                        ),
                                        Color(0xffFEDA77),
                                      ],
                                      tileMode: TileMode.repeated,
                                    ).createShader(bounds);
                                  }),
                                  child: FaIcon(
                                      FontAwesomeIcons.instagramSquare,
                                      color: Colors.white)),
                              iconSize: 30),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Text(
                        'الوصف',
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      // width: 300,
                      // height: 100,
                      margin: EdgeInsets.all(3),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          widget.description!,
                          textAlign: TextAlign.end,
                          // style: TextStyle(height: 1.2),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Wrap(
                        spacing: 15,
                        alignment: WrapAlignment.end,
                        children: [
                          Text('مائية#', style: TextStyle(color: Colors.grey[400]),),
                          Text('حركية#', style: TextStyle(color: Colors.grey[400]),),
                          Text('ذكاء#', style: TextStyle(color: Colors.grey[400]),),
                          Text('مرح#', style: TextStyle(color: Colors.grey[400]),),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    //   Text('${widget.user!.username!} اضاف هذا المكان'),
                    //   Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: CircleAvatar(
                    //       foregroundImage:
                    //           NetworkImage(widget.user!.profilePic!),
                    //       backgroundColor: Colors.blue,
                    //       radius: 20,
                    //     ),
                    //   ),
                    // ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 1, left: 15),
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(),
                                  height: expand ? 296 : 64,
                                  width: 199,
                                  child: Card(
                                    elevation: 7,
                                    child: Column(
                                      children: [
                                        !expand
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    //weekdayIndex == 1, 2, 3, 4, 5, 6, 7 starts with Monday
                                                    // weekdays == 0, 1, 2 ,3, 4, 5, 6 starts with Sunday
                                                    Text(weekdayIndex != 7
                                                        ? widget.weekdays!.firstWhere(
                                                            (element) =>
                                                                widget.weekdays!
                                                                    .indexOf(
                                                                        element) ==
                                                                weekdayIndex,
                                                            orElse: () =>
                                                                'null')
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
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 8.0, bottom: 10.0),
                              child: Text(
                                'ساعات العمل',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
                        child: Text(
                          'الاماكن المشابهة',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      height: 300,
                      child: DayList(
                        isWeekList: false,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

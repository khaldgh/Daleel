import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class FullScreenWidget extends StatefulWidget {
  const FullScreenWidget({Key? key, this.images}) : super(key: key);

  final List<dynamic>? images;

  @override
  State<FullScreenWidget> createState() => _FullScreenWidgetState();
}

class _FullScreenWidgetState extends State<FullScreenWidget> {
  int _imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    double getScreenHeight = MediaQuery.of(context).size.height / 2.5;

    return Scaffold(
      backgroundColor: Colors.black,
      body: InkWell(
        onTap: () {
          int count = 0;
          Navigator.popUntil(context, (route) {
            return count++ == 1;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  height: getScreenHeight,
                  onPageChanged: (int index, CarouselPageChangedReason reason) {
                    setState(() {
                      _imageIndex = index;
                    });
                  },
                  viewportFraction: 1),
              items: widget.images!.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Image.network(i['image'], fit: BoxFit.fill);
                  },
                );
              }).toList(),
            ),
            SizedBox(
              height: 15,
            ),
            CarouselIndicator(
              activeColor: Colors.black45,
              color: Colors.blue,
              count: widget.images!.length,
              index: _imageIndex,
              height: 8,
              width: 8,
              space: 15,
            ),
          ],
        ),
      ),
    );
  }
}

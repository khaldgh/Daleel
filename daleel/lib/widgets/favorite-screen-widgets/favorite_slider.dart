import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:daleel/models/place.dart';
import 'package:flutter/material.dart';

class FavoriteSlider extends StatefulWidget {
  const FavoriteSlider({Key? key, this.places, this.index}) : super(key: key);

  final List<Place>? places;
  final int? index;

  @override
  State<FavoriteSlider> createState() => _FavoriteSliderState();
}

class _FavoriteSliderState extends State<FavoriteSlider> {
  int _imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              viewportFraction: 0.9,
              height: 170.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _imageIndex = index;
                });
              }),
          items: widget.places![widget.index!].images!.map((place) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    child: ClipRRect(
                      child: Image.network(place),
                      borderRadius: BorderRadius.circular(35),
                    ));
              },
            );
          }).toList(),
        ),
        SizedBox(
          height: 10,
        ),
        CarouselIndicator(
          count: widget.places![widget.index!].images!.length,
          index: _imageIndex,
        )
      ],
    );
  }
}

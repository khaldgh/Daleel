import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Rating extends StatefulWidget {
  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  double ratingValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RatingBar.builder(
          itemSize: 24,
          initialRating: 3,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(vertical: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              print(rating);
              ratingValue = rating;
            });
          },
        ),
        Text(ratingValue == 0 ? 'قيم هذا المكان' : ratingValue.toString())
      ],
    );
  }
}

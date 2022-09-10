import 'package:daleel/providers/places.dart';
import 'package:daleel/providers/users.dart';
import 'package:daleel/screens/offers_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OfferItem extends StatelessWidget {
  Text? title;
  Icon? icon;

  OfferItem({
    this.title,
    this.icon,
  });
  @override
  Widget build(BuildContext context) {
    Users users = Provider.of<Users>(context, listen: false);
    Places places = Provider.of<Places>(context, listen: false);
    return InkWell(
      onTap: () {
        users.signout(context);
        // Navigator.of(context).pushNamed(OffersScreen.routeName);
        // users.whoami();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF35A8E1),
                borderRadius: BorderRadius.circular(12),
              ),
              height: 230,
              width: 170,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [icon!, title!],
                ),
              ),
            ),
            Positioned(
              right: 15,
              top: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Container(
                  width: 37,
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      'قريبا',
                      style: TextStyle(shadows: [
                        Shadow(color: Colors.black, offset: Offset(0.5, 0.7))
                      ], fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ]),
        ],
      ),
    );
  }
}

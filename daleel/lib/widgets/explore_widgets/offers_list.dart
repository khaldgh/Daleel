import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'offer_item.dart';
import 'package:daleel/providers/offers.dart';

class OffersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final offerProvider = Provider.of<Offers>(context).offers;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 230, mainAxisSpacing: 10, crossAxisSpacing: 1),
      itemCount: offerProvider.length,
      padding: EdgeInsets.only(left: 10, top: 10),
      physics: ScrollPhysics(),
      itemBuilder: (ctx, i) => OfferItem(
        icon: offerProvider[i].icon,
        title: offerProvider[i].title,
      ),
    );
  }
}

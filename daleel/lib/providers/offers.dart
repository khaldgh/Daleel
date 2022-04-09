import 'package:flutter/material.dart';

import '../models/offer.dart';

class Offers with ChangeNotifier{

List<Offer> _offers = [
  Offer(title: 'Super market', icon: Icons.shopping_cart_outlined),
  Offer(title: 'Electronics', icon: Icons.phonelink),
  Offer(title: 'Cars', icon: Icons.directions_car),
  Offer(title: 'Restaurants', icon: Icons.restaurant_menu),
  Offer(title: 'cafes', icon: Icons.free_breakfast),
];

List<Offer> get offers{
  return [..._offers];
}
}
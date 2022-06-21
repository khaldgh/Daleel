import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import 'package:daleel/providers/places.dart';
import 'package:daleel/widgets/home-widgets/image_card.dart';


class StandardGrid extends StatelessWidget {
  const StandardGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final places = Provider.of<Places>(context).favoritePlaces;
    return GridView.builder(
      itemCount: places.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) => ImageCard(
        image: places[index].images![0],
      ),
    );
  }
}

class StandardStaggeredGrid extends StatelessWidget {
  const StandardStaggeredGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final places = Provider.of<Places>(context).favoritePlaces;
    return StaggeredGridView.countBuilder(
      crossAxisCount: 3,
      itemCount: places.length,
      itemBuilder: (context, index) => ImageCard(
        image: places[index].images![0],
      ),
      staggeredTileBuilder: (index) => StaggeredTile.count(1, 1),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
    );
  }
}

class InstagramSearchGrid extends StatelessWidget {
  const InstagramSearchGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final places = Provider.of<Places>(context).favoritePlaces;
    return StaggeredGridView.countBuilder(
      crossAxisCount: 3,
      itemCount: places.length,
      itemBuilder: (context, index) => ImageCard(
        image: places[index].images![0],
      ),
      staggeredTileBuilder: (index) => StaggeredTile.count(
          (index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
    );
  }
}

class PinterestGrid extends StatelessWidget {
  const PinterestGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final places = Provider.of<Places>(context).favoritePlaces;
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemCount: places.length,
      itemBuilder: (context, index) => ImageCard(
        image: places[index].images![0],
      ),
      staggeredTileBuilder: (index) => StaggeredTile.fit(1),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
    );
  }
}


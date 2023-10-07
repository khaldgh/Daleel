import 'package:daleel/models/category.dart';
import 'package:daleel/shimmers/explore-shimmers/home-shimmers/home_shimmer.dart';
import 'package:daleel/widgets/home-widgets/filter_chip_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:filter_list/filter_list.dart';

import 'package:daleel/models/place.dart';
import 'package:daleel/screens/details_screen.dart';
import 'package:daleel/widgets/home-widgets/image_card.dart';
import 'package:daleel/providers/places.dart';

class PlacesGrid extends StatefulWidget {
  static const routeName = '/places-grid';
  PlacesGrid({this.fetchDetails});
  final Function? fetchDetails;

  @override
  State<PlacesGrid> createState() => _PlacesGridState();
}

class _PlacesGridState extends State<PlacesGrid> {

  List<Category?> filteredCategories = [];

  bool changeFlipWidget = false;
  late Places places;
  late Future<List<Category>> categories;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    places = Provider.of<Places>(context, listen: false);
    categories = places.getCategories();
    // WidgetsBinding.instance.addPostFrameCallback(_afterLayout);

  }

  


  void openFilterDialog() async {
    List<Category> cats = await categories;
    cats.forEach((element) {print(element.toJson());});
      FilterListDialog.display<Category>(
        context,
        listData: cats,
        choiceChipLabel: (category) => category!.category,
        validateSelectedItem: (list, val) => list!.contains(val),
        onItemSearch: (category, query) {
          return category.category.toLowerCase().contains(query.toLowerCase());
        },
        hideSearchField: true,
        hideCloseIcon: true,
        applyButtonText: 'بحث',
        resetButtonText: 'مسح',
        allButtonText: 'الكل',
        selectedItemsText: 'اخترت',
        onApplyButtonClick: (list) {
          setState(() {
            filteredCategories = list!;
          });
          Navigator.pop(context);
        },
      );
    }

    Widget openSnackbar() {
        Provider.of<Places>(context, listen: false).openSnackBar(context);
        return Center(child: CircularProgressIndicator());
    }


  @override
  Widget build(BuildContext context) {


    void filterChipChoice(List<Category?> selectedCategories) {
      filteredCategories = selectedCategories;
      setState(() {
        
      });
    }

    return FutureBuilder(
        future: Provider.of<Places>(context, listen: false).getPlaces(filteredList: filteredCategories),
        builder: (BuildContext context, AsyncSnapshot<List<Place>> snapshot) {
          List<Place> getPlaces = snapshot.data ?? [];
          List<Category?> categories =
              getPlaces.map((e) => e.category).toList();
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : snapshot.hasError
                  ? openSnackbar()
                  : SafeArea(
                      bottom: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: filteredCategories.length == 1 ? Padding(
                                  padding: const EdgeInsets.all(5.5),
                                  child: FilterChip(label: Text('الكل'), onSelected: (bool){
                                    setState(() {
                                      filteredCategories = [];
                                    });
                                  },),)
                                  : 
                                  FilterChipWidget(
                                  categories: categories,
                                  fccFunction: filterChipChoice
                                )
                                
                          //   child: TextButton(
                          //     child: Text('press me'),
                          //     onPressed: openFilterDialog,
                          //   ),
                          ),
                          Expanded(
                            flex: 8,
                            child: Container(
                              child: StaggeredGridView.countBuilder(
                                crossAxisCount: 2,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return ImageCard(
                                  onTap: () {
                                    GoRouter.of(context).push(
                                        '${DetailsScreen.routeName}/${snapshot.data![index].place_id}');
                                  },
                                  image: snapshot.data![index].images![0],
                                  title: snapshot.data![index].title,
                                  category:
                                      snapshot.data![index].category!.category,
                                );
                                },
                                staggeredTileBuilder: (index) =>
                                    StaggeredTile.fit(1),
                                mainAxisSpacing: 8.0,
                                crossAxisSpacing: 8.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
        });
  }
}

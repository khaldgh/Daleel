import 'package:daleel/models/category.dart';
import 'package:flutter/material.dart';

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
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<Places>(context, listen: false).getPlaces();
    print('init');
    super.initState();
  }
     List<Category>? filteredCategories = [];

  bool changeFlipWidget = false;
  @override
  Widget build(BuildContext context) {


    void openFilterDialog() async {
      List<Category> categories = await Provider.of<Places>(context, listen: false).getCategories();
      await FilterListDialog.display<Category>(
        context,
        listData: categories,
        // selectedListData: ['1', '2', '3'],
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
            filteredCategories = list;
            print(filteredCategories);
            // selectedUserList = List.from(list!);
          });
          Navigator.pop(context);
        },
      );
    }

print('before widget build');
print(filteredCategories);
    return FutureBuilder(
        future: Provider.of<Places>(context, listen: false).getPlaces(filteredList: filteredCategories!),
        builder: (BuildContext context, AsyncSnapshot<List<Place>> snapshot) {
          List<Place> getPlaces = snapshot.data ?? [];
          List<String> labels =
              getPlaces.map((e) => e.category!.category).toSet().toList();
          return snapshot.connectionState == ConnectionState.waiting
              ? Center(child: CircularProgressIndicator())
              : snapshot.hasError
                  ? Center(child: Text(snapshot.error.toString()))
                  : SafeArea(
                      bottom: false,
                      child: Column(
                        children: [
                          Expanded(
                            // child: FilterChipWidget(
                            //   count: labels.length,
                            //   labels: labels,
                            // ),
                            child: TextButton(
                              child: Text('press me'),
                              onPressed: openFilterDialog,
                            ),
                            flex: 1,
                          ),
                          Container(
                            child: Expanded(
                              flex: 8,
                              child: StaggeredGridView.countBuilder(
                                crossAxisCount: 2,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) => ImageCard(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        DetailsScreen.routeName,
                                        arguments:
                                            snapshot.data![index].place_id);
                                    // print(count);
                                    // print(snapshot.data![index].place_id);
                                    print(snapshot.data![index].images);
                                  },
                                  image: snapshot.data![index].images![0],
                                  title: snapshot.data![index].title,
                                  category:
                                      snapshot.data![index].category!.category,
                                ),
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

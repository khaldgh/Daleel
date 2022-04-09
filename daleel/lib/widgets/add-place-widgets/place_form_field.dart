import 'package:daleel/models/category.dart';
import 'package:daleel/models/city.dart';
import 'package:daleel/providers/places.dart';
import 'package:daleel/widgets/add-place-widgets/category_chip.dart';
import 'package:daleel/widgets/add-place-widgets/city_chip.dart';
import 'package:daleel/widgets/add-place-widgets/neighborhood_chip.dart';
import 'package:daleel/widgets/add-place-widgets/sub_category_widget.dart';
import 'package:flutter/material.dart';

import 'package:daleel/models/place.dart';
import 'package:provider/provider.dart';
import './custom_text_form_field.dart';
import './custom_drop_button.dart';

class PlaceFormField extends StatefulWidget {
  const PlaceFormField({Key? key}) : super(key: key);

  @override
  _PlaceFormFieldState createState() => _PlaceFormFieldState();
}

class _PlaceFormFieldState extends State<PlaceFormField> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool? categorySelected = false;

  @override
  Widget build(BuildContext context) {
    // void changeBoolValue(bool value) {
    //   setState(() {
    //     categorySelected = value;
    //   });
    // }

    categorySelected;
    Places places = Provider.of<Places>(context, listen: false);
    Place userPlace = places.userPlace;
    List<Place> formPlaces = places.formPlaces;
    Future<List<City>> cities = places.getCities();
    Future<List<Category>> categories = places.getCategories();

    userPlace = Place(
        // place_id: formPlaces.length + 1,
        title: userPlace.title,
        description: userPlace.description,
        category: userPlace.category,
        approved: userPlace.approved,
        instagram: userPlace.instagram,
        website: userPlace.website,
        phone: userPlace.phone,
        neighborhoods: userPlace.neighborhoods,
        weekdays: userPlace.weekdays,
        images: userPlace.images
        );

    return Form(
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _globalKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomTextFormField(
                boldText: 'اسم المكان',
                hintText: 'فلافل الرابية',
                errText: 'اسم المكان لازم يكون 20 حرف كحد اقصى',
                maxLength: 20,
                mandatory: true,
                onSaved: (value) {
                  userPlace = Place(
                      place_id: userPlace.place_id,
                      title: value,
                      category: userPlace.category,
                      description: userPlace.description,
                      images: userPlace.images);
                }),
            CustomTextFormField(
                boldText: 'ليش تحب هذا المكان؟',
                hintText: 'سندويش الفلافل بدبس الرمان, يفتح الى صلاة الفجر',
                errText: 'لازم يكون 15 حرف كحد اقصى',
                maxLength: 15,
                mandatory: true,
                onSaved: (value) {
                  userPlace = Place(
                      place_id: userPlace.place_id,
                      title: userPlace.title,
                      // category: userPlace.category,
                      description: value,
                      images: userPlace.images);
                }),
            CategoryChip(
              title: 'التصنيف',
              // categorySelected: changeBoolValue,
              futureFunction: categories,
              place: userPlace,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: CityChip(
                    futureFunction: cities,
                    title: 'المدينة',
                  ),
                ),
                NeighborhoodChip(),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        final validate = _globalKey.currentState!.validate();
                        validate;
                        _globalKey.currentState!.save();
                        Provider.of<Places>(context, listen: false)
                            .postPlace(userPlace);
                        print(userPlace.title);
                        print(userPlace.description);
                        print(userPlace.category!.category);
                        print(userPlace.approved);
                        print(userPlace.instagram);
                        print(userPlace.website);
                        print(userPlace.images);
                        print(userPlace.weekdays);
                        print(userPlace.phone);
                        print(userPlace.neighborhoods);
                      },
                      child: Text('submit')),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

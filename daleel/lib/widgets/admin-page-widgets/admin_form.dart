import 'package:daleel/models/category.dart';
import 'package:daleel/models/neighborhood.dart';
import 'package:daleel/providers/places.dart';
import 'package:daleel/widgets/admin-page-widgets/admin_text_form_field.dart';
import 'package:daleel/widgets/admin-page-widgets/optional_text_form_field.dart';
import 'package:flutter/material.dart';

import 'package:daleel/models/place.dart';
import 'package:provider/provider.dart';

class AdminForm extends StatefulWidget {
  static const routeName = '/adminForm';
  const AdminForm({Key? key, this.index, this.listOfPlaces, this.updateScreen})
      : super(key: key);
  final int? index;
  final List<Place>? listOfPlaces;
  final Function? updateScreen;
  @override
  _AdminFormState createState() => _AdminFormState();
}

class _AdminFormState extends State<AdminForm> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool? categorySelected = false;

  Place userPlace = Place(
    // id: 0,
    title: 'default title',
    description: 'default desc',
    category: Category(categoryId: 5, category: 'مقاهي'),
    approved: false,
    phone: 0,
    instagram: 'default insta',
    website: 'default web',
    neighborhoods: [
      Neighborhood(
          neighborhoodId: 6, neighborhood: 'العليا', cityId: 1, city: 'الخبر')
    ],
    weekdays: [
      's',
      'm',
      't',
      'w',
      't',
      'f',
      's',
    ],
    images: [],
    // isFavorite: null,
    // time: null
  );

  void addCategory(Category category) {
    userPlace = Place(
        title: userPlace.title,
        description: userPlace.description,
        approved: userPlace.approved,
        category: category,
        images: userPlace.images,
        instagram: userPlace.instagram,
        neighborhoods: userPlace.neighborhoods,
        phone: userPlace.phone,
        website: userPlace.website,
        weekdays: userPlace.weekdays);
  }

  void addNeighborhood(Neighborhood? neighborhood) {
    userPlace = Place(
        title: userPlace.title,
        description: userPlace.description,
        approved: userPlace.approved,
        category: userPlace.category,
        images: userPlace.images,
        instagram: userPlace.instagram,
        neighborhoods: [neighborhood!],
        phone: userPlace.phone,
        website: userPlace.website,
        weekdays: userPlace.weekdays);
  }

  @override
  Widget build(BuildContext context) {
    categorySelected;
    Places places = Provider.of<Places>(context, listen: false);
    return Form(
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _globalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AdminTextFormField(
                initValue: widget.listOfPlaces![widget.index!].title,
                boldText: 'اسم المكان',
                hintText: 'فلافل الرابية',
                errText: 'اسم المكان لازم تكتب 20 حرف اقل شي',
                maxLength: 20,
                mandatory: true,
                onSaved: (value) {
                  userPlace = Place(
                      place_id: userPlace.place_id,
                      title: value,
                      category: userPlace.category,
                      description: userPlace.description,
                      phone: userPlace.phone,
                      website: userPlace.website,
                      approved: userPlace.approved,
                      instagram: userPlace.instagram,
                      neighborhoods: userPlace.neighborhoods,
                      weekdays: userPlace.weekdays,
                      images: userPlace.images);
                }),
            AdminTextFormField(
                initValue: widget.listOfPlaces![widget.index!].description,
                boldText: 'ليش تحب هذا المكان؟',
                hintText: 'سندويش الفلافل بدبس الرمان, يفتح الى صلاة الفجر',
                errText: 'لازم تكتب 15 حرف اقل شي',
                maxLength: 15,
                mandatory: true,
                onSaved: (value) {
                  userPlace = Place(
                      place_id: userPlace.place_id,
                      title: userPlace.title,
                      category: userPlace.category,
                      description: value,
                      phone: userPlace.phone,
                      website: userPlace.website,
                      approved: userPlace.approved,
                      instagram: userPlace.instagram,
                      neighborhoods: userPlace.neighborhoods,
                      weekdays: userPlace.weekdays,
                      images: userPlace.images);
                }),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 38.0),
              child: Text(
                widget.listOfPlaces![widget.index!].category!.category!,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 18.0),
              child: Text(
                  widget.listOfPlaces![widget.index!].neighborhoods![0].city!,
                  style: TextStyle(fontSize: 20.0)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 18.0),
              child: Text(
                  (widget.listOfPlaces![widget.index!].neighborhoods![0]
                      .neighborhood!),
                  style: TextStyle(fontSize: 20.0)),
            ),
            // OptionalTextFormField(
            //   boldText: 'الموقع',
            //     hintText:
            //         'https://g.page/shawermagysa?share',
            //     errText: 'لازم تكتب 15 حرف اقل شي',
            //     maxLength: 15,
            //     mandatory: true,
            //     onSaved: (value) {
            //       userPlace = Place(
            //           place_id: userPlace.place_id,
            //           title: userPlace.title,
            //           category: userPlace.category,
            //           description: value,
            //           phone: userPlace.phone,
            //           website: userPlace.website,
            //           approved: userPlace.approved,
            //           instagram: userPlace.instagram,
            //           neighborhoods: userPlace.neighborhoods,
            //           weekdays: userPlace.weekdays,
            //           images: userPlace.images);
            //     }
            // ),
            OptionalTextFormField(
                initValue: widget.listOfPlaces![widget.index!].phone.toString(),
                boldText: 'رقم التواصل',
                hintText: '0135846245',
                errText: 'لازم تكتب 15 حرف اقل شي',
                maxLength: 15,
                mandatory: true,
                onSaved: (value) {
                  userPlace = Place(
                      place_id: userPlace.place_id,
                      title: userPlace.title,
                      category: userPlace.category,
                      description: userPlace.description,
                      phone: int.parse(value!),
                      website: userPlace.website,
                      approved: userPlace.approved,
                      instagram: userPlace.instagram,
                      neighborhoods: userPlace.neighborhoods,
                      weekdays: userPlace.weekdays,
                      images: userPlace.images);
                }),
            OptionalTextFormField(
                initValue: widget.listOfPlaces![widget.index!].website,
                boldText: 'الموقع الالكتروني',
                hintText: 'www.daleel.com',
                errText: 'لازم تكتب 15 حرف اقل شي',
                maxLength: 15,
                mandatory: true,
                onSaved: (value) {
                  userPlace = Place(
                      place_id: userPlace.place_id,
                      title: userPlace.title,
                      category: userPlace.category,
                      description: userPlace.description,
                      phone: userPlace.phone,
                      website: value,
                      approved: userPlace.approved,
                      instagram: userPlace.instagram,
                      neighborhoods: userPlace.neighborhoods,
                      weekdays: userPlace.weekdays,
                      images: userPlace.images);
                }),
            OptionalTextFormField(
                initValue: widget.listOfPlaces![widget.index!].instagram,
                boldText: 'الانستقرام',
                hintText: 'www.insta.com',
                errText: 'لازم تكتب 15 حرف اقل شي',
                maxLength: 15,
                mandatory: true,
                onSaved: (value) {
                  userPlace = Place(
                      place_id: userPlace.place_id,
                      title: userPlace.title,
                      category: userPlace.category,
                      description: userPlace.description,
                      phone: userPlace.phone,
                      website: userPlace.website,
                      approved: userPlace.approved,
                      instagram: value,
                      neighborhoods: userPlace.neighborhoods,
                      weekdays: userPlace.weekdays,
                      images: userPlace.images);
                }),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              IconButton(
                icon: Icon(Icons.photo),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () {},
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 70.0),
                  child: ElevatedButton(
                      onPressed: () {
                        places.deletePlace(
                            widget.listOfPlaces![widget.index!].place_id!);
                        widget.updateScreen!();
                      },
                      child: Text('رفض'),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red))),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 50.0),
                  child: ElevatedButton(
                      onPressed: () {
                        // print(userPlace.title);
                        // print(userPlace.description);
                        // print(userPlace.category!.toJson());
                        // print(
                        //     '${userPlace.neighborhoods![0].toJson()} submit button');
                        // print(userPlace.approved);
                        // print(userPlace.instagram);
                        // print(userPlace.website);
                        // print(userPlace.images);
                        // print(userPlace.weekdays);
                        // print(userPlace.phone);

                        _globalKey.currentState!.validate();

                        _globalKey.currentState!.save();

                        userPlace.place_id =
                            widget.listOfPlaces![widget.index!].place_id!;

                        userPlace.approved = true;

                        userPlace;

                        places.changeApprovalStatus(userPlace);

                        print(userPlace.place_id);

                        widget.updateScreen!();
                      },
                      child: Text('قبول'),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green))),
                ),
              ],
            )
          ],
        ));
  }
}

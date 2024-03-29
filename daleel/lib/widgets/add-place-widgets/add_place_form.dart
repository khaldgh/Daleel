import 'dart:io';

import 'package:daleel/models/user.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
// import 'package:amplify_flutter/amplify_flutter.dart';
// import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:images_picker/images_picker.dart';

import 'package:daleel/models/category.dart';
import 'package:daleel/models/city.dart';
import 'package:daleel/models/neighborhood.dart';
import 'package:daleel/providers/places.dart';
import 'package:daleel/widgets/add-place-widgets/category_chip.dart';
import 'package:daleel/widgets/add-place-widgets/city_chip.dart';
import 'package:daleel/widgets/add-place-widgets/neighborhood_chip.dart';

import 'package:daleel/models/place.dart';
import 'add_place_text_form_field.dart';
import './custom_drop_button.dart';

class AddPlaceForm extends StatefulWidget {
  const AddPlaceForm({Key? key}) : super(key: key);

  @override
  _AddPlaceFormState createState() => _AddPlaceFormState();
}

class _AddPlaceFormState extends State<AddPlaceForm> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool? categorySelected = false;

  Place userPlace = Place(
    // id: 0,
    title: 'default title',
    description: 'default desc',
    category: Category(categoryId: 5, category: 'default cat'),
    approved: false,
    phone: 0,
    instagram: 'default insta',
    website: 'default web',
    neighborhoods: [],
    // user: User(user_id: 30),
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

  void addCategory(Category? category) {
    userPlace = Place(
        title: userPlace.title,
        description: userPlace.description,
        approved: userPlace.approved,
        category: category,
        images: userPlace.images,
        instagram: userPlace.instagram,
        neighborhoods: userPlace.neighborhoods,
        // user: User(user_id: 30),
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
        // user: User(user_id: 30),
        phone: userPlace.phone,
        website: userPlace.website,
        weekdays: userPlace.weekdays);
  }

  List<Media>? pickedImage;

  onImageAdded(ImageSource? source) async {
    pickedImage = await ImagesPicker.pick(count: 8);
  }

  Future<void> onImageSubmitted({String? category, dynamic fileName}) async {
    // try {
    //   for (int i = 0; i < pickedImage!.length; i++) {
    //     var exampleFile = File(pickedImage![i].path);
    //      await Amplify.Storage.uploadFile(
    //         local: exampleFile,
    //         //     options:  S3UploadFileOptions(
    //         //   accessLevel: StorageAccessLevel.guest,
    //         //   contentType: 'text/plain',
    //         //   metadata: <String, String>{
    //         //     'project': 'ExampleProject',
    //         //   },
    //         // ),
    //         key: 'images/$category/${await fileName}/$i',
    //         onProgress: (progress) {
    //           print("Fraction completed: " +
    //               progress.getFractionCompleted().toString());
    //         });
    //     print('Successfully uploaded file: '); //${result.key}
    //   }
    // } on StorageException catch (e) {
    //   print('Error uploading file: $e');
    // }
  }

  @override
  Widget build(BuildContext context) {
    categorySelected;
    Places places = Provider.of<Places>(context, listen: false);
    if (places.neighborhoods!.isNotEmpty)
      places.neighborhoods!.clear(); // to clear neighborhoods on setState();
    // Place userPlace = places.userPlace;
    List<Place> formPlaces = places.formPlaces;
    Future<List<City>> cities = places.getCities();
    Future<List<Category>> categories = places.getCategories();

    return Form(
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _globalKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AddPlaceTextFormField(
                boldText: 'اسم المكان',
                hintText: 'فلافل الرابية',
                errText: 'اسم المكان لازم تكتب 20 حرف اقل شي',
                maxLength: 20,
                mandatory: true,
                onSaved: (value) {
                  print('title');
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
                      // user: User(user_id: 30),
                      weekdays: userPlace.weekdays,
                      images: userPlace.images);
                }),
            AddPlaceTextFormField(
                boldText: 'ليش تحب هذا المكان؟',
                hintText: 'سندويش الفلافل بدبس الرمان, يفتح الى صلاة الفجر',
                errText: 'لازم تكتب 15 حرف اقل شي',
                maxLength: 15,
                mandatory: true,
                onSaved: (value) {
                  print('description');
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
                      // user: User(user_id: 30),
                      weekdays: userPlace.weekdays,
                      images: userPlace.images);
                }),
            SizedBox(
              height: 30,
            ),
            Text('اضف صور للمكان',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () {
                      onImageAdded(ImageSource.camera);
                    }),
                IconButton(
                    icon: Icon(Icons.photo),
                    onPressed: () {
                      onImageAdded(ImageSource.gallery);
                    }),
              ],
            ),
            CategoryChip(
              title: 'التصنيف',
              futureFunction: categories,
              addValue: addCategory,
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
                NeighborhoodChip(
                  addValue: addNeighborhood,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        _globalKey.currentState!.validate();

                        _globalKey.currentState!.save();

                        userPlace;

                        print(userPlace.category!.category);

                        var placeId =
                            Provider.of<Places>(context, listen: false)
                                .postPlace(userPlace);

                        onImageSubmitted(
                          category: userPlace.category!.category,
                          fileName: placeId,
                        );

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

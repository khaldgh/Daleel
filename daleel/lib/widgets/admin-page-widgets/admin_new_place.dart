import 'dart:io';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:daleel/models/category.dart';
import 'package:daleel/models/city.dart';
import 'package:daleel/models/neighborhood.dart';
import 'package:daleel/models/place.dart';
import 'package:daleel/providers/places.dart';
import 'package:daleel/providers/subcategories.dart';
import 'package:daleel/widgets/add-place-widgets/add_place_text_form_field.dart';
import 'package:daleel/widgets/add-place-widgets/category_chip.dart';
import 'package:daleel/widgets/add-place-widgets/city_chip.dart';
import 'package:daleel/widgets/add-place-widgets/neighborhood_chip.dart';
import 'package:daleel/widgets/admin-page-widgets/weekday_picker.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:images_picker/images_picker.dart';
import 'package:intl/date_symbols.dart';
import 'package:provider/provider.dart';

class AdminNewPlace extends StatefulWidget {
  static const routeName = '/test-screen2';
  const AdminNewPlace({Key? key}) : super(key: key);

  @override
  State<AdminNewPlace> createState() => _AdminNewPlaceState();
}

class _AdminNewPlaceState extends State<AdminNewPlace> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool? categorySelected = false;
  List<String> chosenWeekdays = [];
  String workingHours = '';
  String selectedDropDownItem = '';
  List<String> weekdays = [
    'الاحد',
    'الاثنين',
    'الثلاثاء',
    'الاربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
  ];
  List<DropdownMenuItem> subcats = [
    DropdownMenuItem(child: Text('اطفال')),
    DropdownMenuItem(child: Text('كبار')),
    DropdownMenuItem(child: Text('مائية')),
    DropdownMenuItem(child: Text('حركية')),
    DropdownMenuItem(child: Text('ذكاء')),
  ];

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
      'الاحد',
      'الاثنين',
      'الثلاثاء',
      'الاربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
    ],
    images: [],
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
    try {
      for (int i = 0; i < pickedImage!.length; i++) {
        var exampleFile = File(pickedImage![i].path);
        await Amplify.Storage.uploadFile(
            local: exampleFile,
            //     options:  S3UploadFileOptions(
            //   accessLevel: StorageAccessLevel.guest,
            //   contentType: 'text/plain',
            //   metadata: <String, String>{
            //     'project': 'ExampleProject',
            //   },
            // ),
            key: 'images/$category/${await fileName}/$i',
            onProgress: (progress) {
              print("Fraction completed: " +
                  progress.getFractionCompleted().toString());
            });
        print('Successfully uploaded file: '); //${result.key}
      }
    } on StorageException catch (e) {
      print('Error uploading file: $e');
    }
  }

  void fetchWeekdayPickerValues(
      List<int> pickerWeekdays, String openingTime, String closingTime) {
    print(pickerWeekdays);
    // print(openingTime);
    // print(closingTime);
    chosenWeekdays.clear();
    pickerWeekdays.forEach((element) {
      chosenWeekdays.add(weekdays[element]);
      print(chosenWeekdays);
      this.userPlace.weekdays![element] = '$openingTime - $closingTime';
      workingHours = this.userPlace.weekdays![element];
    });
    setState(() {});
    userPlace = Place(
        title: userPlace.title,
        description: userPlace.description,
        approved: userPlace.approved,
        category: userPlace.category,
        images: userPlace.images,
        instagram: userPlace.instagram,
        neighborhoods: userPlace.neighborhoods,
        phone: userPlace.phone,
        website: userPlace.website,
        weekdays: this.userPlace.weekdays);
    // print(userPlace.weekdays);
  }

  @override
  Widget build(BuildContext context) {
    categorySelected;
    Places places = Provider.of<Places>(context, listen: false);
    Subcategories subcategories =
        Provider.of<Subcategories>(context, listen: false);
    if (places.neighborhoods!.isNotEmpty)
      places.neighborhoods!.clear(); // to clear neighborhoods on setState();
    // Place userPlace = places.userPlace;
    List<Place> formPlaces = places.formPlaces;
    Future<List<City>> cities = places.getCities();
    Future<List<Category>> categories = places.getCategories();
    return SafeArea(
      child: Form(
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
              Text('اضف ساعات العمل',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: WeekdayPicker(fetchWeekdayPickerValues),
                          );
                        });
                  },
                  child: Text('اضغط للاضافة')),
              Container(
                  height: 110,
                  width: 300,
                  child: Card(
                    color: Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'الايام: $chosenWeekdays',
                          textDirection: TextDirection.rtl,
                        ),
                        Text(
                          'الوقت:',
                          textDirection: TextDirection.rtl,
                        ),
                        Text(workingHours)
                      ],
                    ),
                  )),
              // WeekdayPicker(),
              CategoryChip(
                title: 'التصنيف',
                futureFunction: categories,
                addValue: addCategory,
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: DropdownSearch<String>.multiSelection(
                  asyncItems: ((text) {
                   return Provider.of<Subcategories>(context, listen: false).getSubcategoriesOfSingleCategory(1);
                  }),
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        constraints: BoxConstraints(maxWidth: 320)),
                  ),
                  // items: ["اطفال", "كبار", 'مائية'],
                  popupProps: PopupPropsMultiSelection.dialog(
                    showSearchBox: true,
                    showSelectedItems: true,
                  ),
                  onChanged: print,
                  // selectedItems: ["Brazil"],
                ),
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

                          userPlace.approved = true;

                          Future<dynamic> placeId =
                              Provider.of<Places>(context, listen: false)
                                  .postPlace(userPlace);

                          onImageSubmitted(
                            category: userPlace.category!.category,
                            fileName: placeId,
                          );

                          print(userPlace.title);
                          print(userPlace.description);
                          print(userPlace.category!.toJson());
                          print(
                              '${userPlace.neighborhoods![0].toJson()} submit button');
                          print(userPlace.approved);
                          print(userPlace.instagram);
                          print(userPlace.website);
                          print(userPlace.images);
                          print(userPlace.weekdays);
                          print(userPlace.phone);
                        },
                        child: Text('submit')),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:daleel/providers/places.dart';
import 'package:daleel/widgets/add-place-widgets/custom_drop_button.dart';
import 'package:daleel/widgets/add-place-widgets/custom_text_form_field.dart';
import 'package:daleel/widgets/admin-page_widgets/admin_drop_button.dart';
import 'package:daleel/widgets/admin-page_widgets/admin_form_field.dart';
import 'package:flutter/material.dart';

import 'package:daleel/models/place.dart';
import 'package:provider/provider.dart';

class AdminFormField extends StatefulWidget {
  static const routename = 'admin-form-field';
  const AdminFormField({Key? key}) : super(key: key);

  @override
  _AdminFormFieldState createState() => _AdminFormFieldState();
}

class _AdminFormFieldState extends State<AdminFormField> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
  Place userPlace = Provider.of<Places>(context).userPlace;
  List<Place> formPlaces = Provider.of<Places>(context).formPlaces;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Form(
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _globalKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomTextFormField(
                      initValue: formPlaces[0].title,
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
                            images: userPlace.images
                          );
                        }),
                    AdminDropButton(boldText: 'التصنيف'),
                    // CustomDropButton(boldText: 'التصنيف الفرعي'),
                    // CustomDropButton(boldText: 'المدينة'),
          
                    CustomTextFormField(
                      initValue: formPlaces[0].description,
                        boldText: 'ليش تحب هذا المكان؟',
                        hintText: 'سندويش الفلافل بدبس الرمان, يفتح الى صلاة الفجر',
                        errText: 'لازم يكون 15 حرف كحد اقصى',
                        maxLength: 15,
                        mandatory: true,
                        onSaved: (value) {
                          userPlace = Place(
                            place_id: userPlace.place_id,
                            title: userPlace.title,
                            category: userPlace.category,
                            description: value,
                            images: userPlace.images
                          );
                        }),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      final validate = _globalKey.currentState!.validate();
                      validate;
                      _globalKey.currentState!.save(); 
                      print(userPlace.title);
                      print(userPlace.description);
                      print(userPlace.place_id);
                      print(userPlace.images);
                    },
                    child: Text('submit'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:daleel/models/place.dart';
import 'package:daleel/widgets/add-place-widgets/place_form_field.dart';
import 'package:flutter/material.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);
  static const routeName = 'add-place-screen';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  // TextEditingController title = TextEditingController();
  //   List<String> numbers = ['1', '2', '3', '4'];
  //   String dropdownvalue = '1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('اضف مكان جديد')),
      body: SafeArea(
        child: PlaceFormField(),
      ),
    );
  }
}

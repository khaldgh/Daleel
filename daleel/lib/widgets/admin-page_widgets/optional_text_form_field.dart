import 'package:flutter/material.dart';

class OptionalTextFormField extends StatelessWidget {
  OptionalTextFormField(
      {this.initValue,
      this.hintText,
      this.errText,
      this.onSaved,
      this.boldText,
      this.maxLength,
      this.mandatory,
      Key? key})
      : super(key: key);
  final String? initValue;
  @required
  final String? boldText;
  @required
  final String? hintText;
  @required
  final String? errText;
  @required
  final int? maxLength;
  final bool? mandatory;
  @required
  final Function(String?)? onSaved;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 0.0, right: 20),
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text.rich(TextSpan(
              text: boldText,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
              children: <TextSpan>[
                mandatory!
                    ? TextSpan(
                        text: '*',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.red),
                      )
                    : TextSpan(text: ''),
              ])),
          Padding(
            padding: const EdgeInsets.only(left: 60.0),
            child: TextFormField(
                initialValue: initValue,
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15),
                    hintText: hintText,
                    hintTextDirection: TextDirection.rtl),
                validator: (String? value) {
                  if (value!.length > maxLength!) {
                    return errText;
                  } else if (mandatory! && value.isEmpty) {
                    return 'هذي الخانة ضرورية';
                  } else {
                    return null;
                  }
                },
                onSaved: onSaved),
          ),
        ],
      ),
    );
  }
}

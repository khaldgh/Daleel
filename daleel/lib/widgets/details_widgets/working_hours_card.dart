import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorkingHoursCard extends StatelessWidget {
  WorkingHoursCard(this.weekdaysValues);
  final List<String>? weekdaysValues;
  final List<String> weekdays = [
    'الاحد',
    'الاثنين',
    'الثلاثاء',
    'الاربعاء',
    'الخميس',
    'الجمعة',
    'السبت'
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 7,
      itemBuilder: (BuildContext context, int i) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(weekdaysValues![i]),
            SizedBox(
              width: 10,
            ),
            Text(weekdays[i]),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeekdayPicker extends StatefulWidget {
  Function fetchValues;
  WeekdayPicker(this.fetchValues, {Key? key}) : super(key: key);

  @override
  State<WeekdayPicker> createState() => _WeekdayPickerState();
}

class _WeekdayPickerState extends State<WeekdayPicker> {
  bool isSelected = false;
  bool moreTime = false;
  TextEditingController openingTime = TextEditingController();
  TextEditingController closingTime = TextEditingController();
  List<int> selectedWeekdays = [];
  List<int> confirmedWeekdays = [];
  TimeOfDay firstPeriod = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay secondPeriod = TimeOfDay(hour: 0, minute: 0);
  final weekdays = ['اح', 'اث', 'ث', 'ار', 'خ', 'ج', 'س'];

  void openingTimePicker() async {
    TimeOfDay? firstPicker = await showTimePicker(
        context: context,
        initialTime: firstPeriod,
        helpText: 'ادخل الفترة الاولى',
        cancelText: 'الغاء',
        confirmText: 'تأكيد',
        hourLabelText: 'الساعة',
        minuteLabelText: 'الدقيقة',
        builder: (BuildContext context, child) {
          return MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false), child: child ?? Container(),);
        },
        initialEntryMode: TimePickerEntryMode.input);

    if (firstPicker != null) {
      setState(() {
        DateTime tempDate = DateFormat('HH:mm').parse(firstPicker.hour.toString() + ':' + firstPicker.minute.toString());
        var dateFormat = DateFormat('h:mm a');
        openingTime.text = dateFormat.format(tempDate).toString();
      });
    }
  }

  closingTimePicker() async {
    TimeOfDay? secondPicker = await showTimePicker(
        context: context,
        initialTime: secondPeriod,
        helpText: 'ادخل الوقت',
        cancelText: 'الغاء',
        confirmText: 'تأكيد',
        hourLabelText: 'الساعة',
        minuteLabelText: 'الدقيقة',
        builder: (BuildContext context, child) {
          return MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false), child: child ?? Container(),);
        },
        initialEntryMode: TimePickerEntryMode.input);

    if (secondPicker != null) {
      setState(() {
        DateTime tempDate = DateFormat('HH:mm').parse(secondPicker.hour.toString() + ':' + secondPicker.minute.toString());
        var dateFormat = DateFormat('h:mm a');
        closingTime.text = dateFormat.format(tempDate).toString();
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    openingTime.dispose();
    closingTime.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: double.infinity,
      color: Color.fromARGB(118, 77, 192, 207),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'ايام الاسبوع',
            style: TextStyle(fontSize: 18),
            // textDirection: TextDirection.rtl,
          ),
          Container(
            height: 60,
            child: Expanded(
              child: ListView.builder(
                itemCount: weekdays.length,
                itemExtent: 33,
                scrollDirection: Axis.horizontal,
                reverse: true,
                itemBuilder: (BuildContext context, int index) {
                  return RawMaterialButton(
                    padding: EdgeInsets.all(9),
                    constraints: BoxConstraints(minWidth: 25, maxWidth: 55),
                    fillColor: selectedWeekdays
                            .contains(weekdays.indexOf(weekdays[index]))
                        ? Color(0xFF35A8E1)
                        : Colors.white,
                    shape: CircleBorder(side: BorderSide()),
                    child: Text(
                      weekdays[index],
                      style: TextStyle(fontSize: 10),
                    ),
                    onPressed: () {
                      setState(
                        () {
                          if (selectedWeekdays.isEmpty ||
                              !selectedWeekdays.contains(
                                  weekdays.indexOf(weekdays[index]))) {
                            selectedWeekdays
                                .add(weekdays.indexOf(weekdays[index]));
                            isSelected = !isSelected;
                          } else {
                            selectedWeekdays
                                .remove(weekdays.indexOf(weekdays[index]));
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Container(
            height: 50,
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 100,
                    margin: EdgeInsets.all(5),
                    child: TextField(
                      readOnly: true,
                      style: TextStyle(fontSize: 10, ),
                      controller: closingTime,
                        decoration: InputDecoration(
                          label: Text('وقت الاغلاق', style: TextStyle(fontSize: 10, ),),
                          // hintTextDirection: TextDirection.rtl,
                            border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),), onTap: (){
                      closingTimePicker();
                    },),
                  ),
                  Container(
                    height: 50,
                    width: 100,
                    margin: EdgeInsets.all(5),
                    child: TextField(
                      readOnly: true,
                      style: TextStyle(fontSize: 10, ),
                      controller: openingTime,
                      decoration: InputDecoration(
                        label: Text('وقت الافتتاح', style: TextStyle(fontSize: 10, ),),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onTap:
                        openingTimePicker
                      ,
                    ),
                  ),
                ],
              ),
            ),
          ),
          TextButton(child: Text('تأكيد'), onPressed: (){
            // print(selectedWeekdays);
            // print(weekdays);
            List<int> numberedWeekdays = [];
            for(int index1 = 0; index1 < weekdays.length; index1++) {
              for(int index2 = 0; index2 < selectedWeekdays.length; index2++) {
                if(weekdays.indexOf(weekdays[index1]) == selectedWeekdays[index2]) {
                  numberedWeekdays.add(weekdays.indexOf(weekdays[index1]));
                }
              }
            }
        confirmedWeekdays = numberedWeekdays;
        widget.fetchValues(confirmedWeekdays, openingTime.text, closingTime.text);
            Navigator.pop(context);
          },)
        ],
      ),
    );
  }
}

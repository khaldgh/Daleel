import 'package:daleel/providers/places.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestScreen extends StatelessWidget {
  static const routeName = 'testScreen';
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var places = Provider.of<Places>(context);
    return FutureBuilder(
      future: places.getCities(),
      builder: (BuildContext context, AsyncSnapshot snapshot) => Center(
        child: TextButton(
          onPressed: (){
            // places.neighborhoodQuery('الدمام');
            List<String> numbers = ['1','2','3','4','5'];
        //     bool numberExists =
        // numbers.forEach((element) {
          
        // });
            // print(numberExists);
            },
          child: Text('Press to test'),
        ),
      ),
    );
  }
}


import 'package:daleel/screens/login_screen.dart';
import 'package:daleel/widgets/explore_widgets/offer_item.dart';
import 'package:flutter/material.dart';

class CapitalPlaces extends StatelessWidget {
  static const routeName = '/test-screen3';

  const CapitalPlaces({ Key? key }) : super(key: key);

  
  @override
  Widget build(BuildContext context) {

    return  ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        itemBuilder: (BuildContext, int) => Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.orange[400],
                borderRadius: BorderRadius.circular(12),
              ),
              height: 50,
              width: 290,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.category,
                      size: 35,
                    ),
                    Text(
                      'title',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
        ),
      );
  }
}
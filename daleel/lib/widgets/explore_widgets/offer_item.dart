import 'package:flutter/material.dart';

class OfferItem extends StatelessWidget {
  String? title;
  IconData? icon;

  OfferItem({
    this.title,
    this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (_) {
              return Container(
                
                color: Colors.red,
                child: Center(child: Text('hi'),),
              );
            });
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.orange[400],
              borderRadius: BorderRadius.circular(12),
            ),
            height: 230,
            width: 190,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 35,
                  ),
                  Text(
                    title!,
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

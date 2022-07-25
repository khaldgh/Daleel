import 'package:flutter/material.dart';

class DWItem extends StatelessWidget {
  const DWItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(12)),
        height: 170,
        width: 150);
  }
}

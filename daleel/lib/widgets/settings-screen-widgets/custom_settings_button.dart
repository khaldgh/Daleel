import 'package:flutter/material.dart';

class CustomSettingsButton extends StatelessWidget {
  const CustomSettingsButton({Key? key, this.label, this.icon, this.onTap}) : super(key: key);

  final String? label;
  final IconData? icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(label!, style: TextStyle(fontSize: 23)),
          SizedBox(
            width: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Icon(icon!),
          ),
        ],
      ),
    );
  }
}

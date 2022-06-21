import 'package:flutter/material.dart';

class MyNavigationBar extends StatelessWidget {
  final int? selectedIndex;
  final Function(int)? changeIndex;
  

  MyNavigationBar({
    @required this.changeIndex,
    @required this.selectedIndex,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, 0.1),
      height: 100,
      padding: EdgeInsets.only(top:20, bottom:  20, right: 40, left: 40),
      decoration: BoxDecoration(
        // color: Colors.blue,
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey[300],
          showUnselectedLabels: true,
          selectedItemColor: Colors.blue,
          currentIndex: selectedIndex!,
          showSelectedLabels: true,
          onTap: changeIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'favorites'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_rounded), label: 'Settings'),
            BottomNavigationBarItem(icon: Icon(Icons.loop_sharp), label: 'test'),

          ],
        ),
      ),
    );
  }
}

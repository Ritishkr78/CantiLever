import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatefulWidget {
  final int selectedItem;
  final Function(int) onTap;

  const BottomNavBar(
      {required this.onTap, required this.selectedItem, super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.grey[100],
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: w * .015,
          vertical: h * .01,
        ),
        child: GNav(
          gap: 10,
          tabBorderRadius: 100,
          backgroundColor: Colors.grey[100]!,
          activeColor: Colors.white,
          color: const Color.fromARGB(255, 130, 57, 5),
          tabBackgroundGradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 84, 35, 6),
              Color.fromARGB(255, 201, 114, 67)
            ],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
          iconSize: 30,
          textSize: 18,
          padding: EdgeInsets.symmetric(horizontal: w * .01, vertical: h * .01),
          tabs: const [
            GButton(icon: CupertinoIcons.home, text: 'Home'),
            GButton(icon: Icons.category, text: 'Categoriees'),
            GButton(icon: Icons.favorite, text: 'Favourites'),
          ],
          onTabChange: widget.onTap,
          selectedIndex: 0,
        ),
      ),
    );
  }
}

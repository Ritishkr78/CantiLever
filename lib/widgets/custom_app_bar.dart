import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({required this.title, required this.back, super.key});
  final String title;
  final bool back;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    // final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: w * .06,
            letterSpacing: 2,
            color: Colors.white),
      ),
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 233, 44, 44),
    );
  }
}

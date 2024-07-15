import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton(
      {required this.icon, this.color, required this.label, super.key});
  final IconData icon;
  final Color? color;
  final String label;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        CircleAvatar(
          radius: w * .06,
          backgroundColor: const Color.fromARGB(216, 35, 14, 14),
          child: Center(
            child: Icon(
              icon,
              color: color,
            ),
          ),
        ),
        SizedBox(
          height: h * .005,
        ),
        Text(label),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Greet extends StatefulWidget {
  const Greet({super.key});
  @override
  State<Greet> createState() {
    return _GreetState();
  }
}

class _GreetState extends State<Greet> {
  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.now();
    String greeting;

    if (currentTime.hour < 12) {
      greeting = 'Good Morning!';
    } else if (currentTime.hour < 17) {
      greeting = 'Good Afternoon!';
    } else {
      greeting = 'Good Evening!';
    }

    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
      ),
      child: Text(
        greeting,
        style: GoogleFonts.lato(
          color: const Color.fromARGB(255, 215, 82, 5),
          fontSize: 35,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

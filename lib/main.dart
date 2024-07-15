import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:home_made/screens/onboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await Hive.initFlutter();
  await Hive.openBox('saved');
  await Hive.openBox('ingredient');

  runApp(
    const MaterialApp(
      home: OnboardScreen(),
    ),
  );
}

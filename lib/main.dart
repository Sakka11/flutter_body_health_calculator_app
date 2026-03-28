import 'package:flutter/material.dart';
import 'package:flutter_body_health_calculator_app/views/splash_screen_ui.dart';
import 'package:google_fonts/google_fonts.dart';

//----------------------------------------------------
void main() {
  runApp(
    FlutterBodyHealthCalculatorApp(),
  );
}

//----------------------------------------------------
class FlutterBodyHealthCalculatorApp extends StatefulWidget {
  const FlutterBodyHealthCalculatorApp({super.key});

  @override
  State<FlutterBodyHealthCalculatorApp> createState() =>
      _FlutterBodyHealthCalculatorAppState();
}

class _FlutterBodyHealthCalculatorAppState
    extends State<FlutterBodyHealthCalculatorApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenUi(),
      theme: ThemeData(
          textTheme: GoogleFonts.keaniaOneTextTheme(
        Theme.of(context).textTheme,
      )),
    );
  }
}

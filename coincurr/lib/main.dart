import 'package:coincurr/components/reusable_card.dart';
import 'package:coincurr/screens/price_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
          primaryColor: const Color(0xFF1C1A25),
          scaffoldBackgroundColor: const Color(0xFF07060B),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.white,
        ),
      ),
      home: const PriceScreen(),
    );
  }
}


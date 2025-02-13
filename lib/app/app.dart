// lib/app/app.dart
import 'package:flutter/material.dart';
import '../features/home/screens/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}

import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/home/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bubble House Biz',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      builder: (context, child) {
        return MediaQuery(
          // This will help prevent text scaling issues
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ScrollConfiguration(
                // This provides cross-platform scrolling behavior
                behavior: ScrollConfiguration.of(context).copyWith(
                    scrollbars: true,
                    physics: const BouncingScrollPhysics(),
                    platform: TargetPlatform.linux // Using Linux for web-like scrolling
                ),
                child: child!,
              );
            },
          ),
        );
      },
      home: const HomeScreen(),
    );
  }
}
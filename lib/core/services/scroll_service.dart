// lib/core/services/scroll_service.dart
import 'package:flutter/material.dart';

class ScrollService {
  static Future<void> scrollToSection(String section, ScrollController controller) async {
    final Map<String, double> sections = {
      'home': 0,
      'about': 800, // Core Values section
      'services': 1600,
      'team': 2400,
      'testimonials': 3200,
    };

    if (sections.containsKey(section)) {
      await controller.animateTo(
        sections[section]!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }
}
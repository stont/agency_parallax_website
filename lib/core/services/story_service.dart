// lib/core/services/story_service.dart
import 'package:flutter/material.dart';

class StoryService extends ChangeNotifier {
  int _currentStoryIndex = 0;
  double _scrollProgress = 0.0;

  int get currentStoryIndex => _currentStoryIndex;
  double get scrollProgress => _scrollProgress;

  void updateStoryProgress(double progress) {
    _scrollProgress = progress;
    notifyListeners();
  }

  void setCurrentStoryIndex(int index) {
    _currentStoryIndex = index;
    notifyListeners();
  }
}
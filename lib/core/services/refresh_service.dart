// lib/core/services/refresh_service.dart
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshService {
  // Controls the refresh state and animation
  final RefreshController refreshController;

  RefreshService() : refreshController = RefreshController();

  // Handles the refresh operation with custom loading animation
  Future<void> handleRefresh(Future<void> Function() onRefresh) async {
    try {
      await onRefresh();
      refreshController.refreshCompleted();
    } catch (e) {
      refreshController.refreshFailed();
    }
  }

  void dispose() {
    refreshController.dispose();
  }
}
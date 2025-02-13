// lib/shared/widgets/story_refresh_wrapper.dart
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StoryRefreshWrapper extends StatelessWidget {
  final Widget child;
  final RefreshController controller;
  final RefreshCallback onRefresh;
  final String refreshingText;
  final String completeText;

  const StoryRefreshWrapper({
    Key? key,
    required this.child,
    required this.controller,
    required this.onRefresh,
    this.refreshingText = "Turning the page...",
    this.completeText = "Story refreshed",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller,
      onRefresh: onRefresh,
      header: CustomHeader(
        builder: (context, mode) {
          Widget body;
          if (mode == RefreshStatus.idle) {
            body = const Text("Pull down to refresh story");
          } else if (mode == RefreshStatus.refreshing) {
            body = Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
                const SizedBox(width: 15),
                Text(refreshingText),
              ],
            );
          } else if (mode == RefreshStatus.completed) {
            body = Text(completeText);
          } else {
            body = const Text("Release to refresh");
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      child: child,
    );
  }
}

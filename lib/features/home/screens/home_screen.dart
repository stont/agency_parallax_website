// lib/features/home/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../../../core/services/refresh_service.dart';
import '../widgets/core_values_story.dart';
import '../widgets/customer_chronicles.dart';
import '../widgets/hero_story_slider.dart';
import '../widgets/services_narrative.dart';
import '../widgets/team_stories.dart';
import '../../../shared/widgets/footer.dart';
import '../../../shared/widgets/floating_contact_buttons.dart';
import '../../../shared/widgets/custom_nav_bar.dart';
import '../../../shared/widgets/custom_drawer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final RefreshService _refreshService = RefreshService();

  @override
  void dispose() {
    _scrollController.dispose();
    _refreshService.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    try {
      // Implement your refresh logic here
      await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

      // Refresh your story content
      await _refreshService.handleRefresh(() async {
        // Update your story content here
        setState(() {
          // Update state with new story content
        });
      });
    } catch (e) {
      // Handle any refresh errors
      debugPrint('Refresh error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavBar(scrollController: _scrollController),
      endDrawer: CustomDrawer(scrollController: _scrollController),
      body: Stack(
        children: [
          SmartRefresher(
            controller: _refreshService.refreshController,
            onRefresh: _onRefresh,
            scrollController: _scrollController,
            physics: const ClampingScrollPhysics(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  HeroStorySlider(),
                  CoreValuesStory(),
                  ServicesNarrative(),
                  TeamStories(),
                  CustomerChronicles(),
                  Footer(),
                ],
              ),
            ),
          ),
          const FloatingContactButtons(),
        ],
      ),
    );
  }
}
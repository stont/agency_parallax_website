import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CoreValuesStory extends StatefulWidget {
  const CoreValuesStory({super.key});

  @override
  State<CoreValuesStory> createState() => _CoreValuesStoryState();
}

class _CoreValuesStoryState extends State<CoreValuesStory> {
  final Map<String, bool> _visibleSections = {
    'problemSolvers': false,
    'customerChampions': false,
    'techInnovators': false,
    'qualityFocus': false,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
      child: Column(
        children: [
          Text(
            'Our Core Values',
            style: Theme.of(context).textTheme.displaySmall,
          ).animate().fadeIn(duration: 600.ms),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth > 800;
              return isDesktop
                  ? _buildDesktopLayout()
                  : _buildMobileLayout();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Wrap(
      spacing: 24,
      runSpacing: 24,
      alignment: WrapAlignment.center,
      children: [
        SizedBox(
          width: 400,
          child: _buildValueCard(
            'Problem Solvers',
            'From complexity to simplicity',
            'assets/animations/lottie/maze_transform.json',
            'problemSolvers',
          ),
        ),
        SizedBox(
          width: 400,
          child: _buildValueCard(
            'Customer Champions',
            'Growing with our customers',
            'assets/animations/lottie/growing_tree.json',
            'customerChampions',
          ),
        ),
        SizedBox(
          width: 400,
          child: _buildValueCard(
            'Tech Innovators',
            'Bridging tradition with technology',
            'assets/animations/lottie/tech_evolution.json',
            'techInnovators',
          ),
        ),
        SizedBox(
          width: 400,
          child: _buildValueCard(
            'Quality Focus',
            'Excellence in every detail',
            'assets/animations/lottie/quality_check.json',
            'qualityFocus',
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildValueCard(
          'Problem Solvers',
          'From complexity to simplicity',
          'assets/animations/lottie/maze_transform.json',
          'problemSolvers',
        ),
        const SizedBox(height: 24),
        _buildValueCard(
          'Customer Champions',
          'Growing with our customers',
          'assets/animations/lottie/growing_tree.json',
          'customerChampions',
        ),
        const SizedBox(height: 24),
        _buildValueCard(
          'Tech Innovators',
          'Bridging tradition with technology',
          'assets/animations/lottie/tech_evolution.json',
          'techInnovators',
        ),
        const SizedBox(height: 24),
        _buildValueCard(
          'Quality Focus',
          'Excellence in every detail',
          'assets/animations/lottie/quality_check.json',
          'qualityFocus',
        ),
      ],
    );
  }

  Widget _buildValueCard(String title, String description, String animationPath, String visibilityKey) {
    return VisibilityDetector(
      key: Key(visibilityKey),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && _visibleSections[visibilityKey] == false) {
          setState(() {
            _visibleSections[visibilityKey] = true;
          });
        }
      },
      child: Card(
        elevation: 4,
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: Lottie.asset(
                  animationPath,
                  animate: _visibleSections[visibilityKey] ?? false,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
              ).animate(
                target: _visibleSections[visibilityKey] ?? false ? 1 : 0,
              ).fadeIn(delay: 300.ms),
              const SizedBox(height: 16),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyLarge,
              ).animate(
                target: _visibleSections[visibilityKey] ?? false ? 1 : 0,
              ).fadeIn(delay: 500.ms),
            ],
          ),
        ),
      ).animate(
        target: _visibleSections[visibilityKey] ?? false ? 1 : 0,
      ).scale(
        duration: 600.ms,
        curve: Curves.easeOut,
      ),
    );
  }
}
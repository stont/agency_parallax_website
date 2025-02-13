// lib/features/home/widgets/team_stories.dart
import 'dart:async';
import 'package:flutter/material.dart';
import '../../../shared/models/team_member.dart';
import '../../../core/constants/assets_path.dart';
import '../controllers/team_stories_controller.dart';

class TeamStories extends StatefulWidget {
  const TeamStories({super.key});

  @override
  State<TeamStories> createState() => _TeamStoriesState();
}

class _TeamStoriesState extends State<TeamStories> {
  late final PageController _pageController;
  late final TeamStoriesController _controller;
  Timer? _autoFlipTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _controller = TeamStoriesController();
    _startAutoFlip();
  }

  void _startAutoFlip() {
    _autoFlipTimer?.cancel();
    _autoFlipTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < _controller.teamMembers.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoFlipTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;
        // Adjust container height based on screen size
        final containerHeight = isSmallScreen ? 600.0 : 400.0;

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          height: containerHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Our Team',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemCount: _controller.teamMembers.length,
                  itemBuilder: (context, index) {
                    return TeamMemberCard(
                      teamMember: _controller.teamMembers[index],
                      isSmallScreen: isSmallScreen,
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                  ...List.generate(
                    _controller.teamMembers.length,
                        (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: CircleAvatar(
                        radius: 4,
                        backgroundColor: _currentPage == index
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class TeamMemberCard extends StatelessWidget {
  final TeamMember teamMember;
  final bool isSmallScreen;

  const TeamMemberCard({
    super.key,
    required this.teamMember,
    required this.isSmallScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: isSmallScreen
            ? SingleChildScrollView(
          child: Column(
            children: [
              _buildImage(),
              const SizedBox(height: 16),
              _buildInfo(),
            ],
          ),
        )
            : Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: AspectRatio(
                aspectRatio: 1,
                child: _buildImage(),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: _buildInfo(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        teamMember.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          teamMember.name,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          teamMember.position,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          teamMember.bio,
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 16),
        _buildSuccessStory(),
      ],
    );
  }

  Widget _buildSuccessStory() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Success Story',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            teamMember.successStory,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
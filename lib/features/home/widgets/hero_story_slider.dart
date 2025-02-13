// lib/features/home/widgets/hero_story_slider.dart
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HeroStorySlider extends StatefulWidget {
  const HeroStorySlider({Key? key}) : super(key: key);

  @override
  State<HeroStorySlider> createState() => _HeroStorySliderState();
}

class _HeroStorySliderState extends State<HeroStorySlider> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;
  final List<VideoPlayerController> _videoControllers = [];

  final List<StoryPanel> _storyPanels = [
    StoryPanel(
      title: "Your Journey Begins Here",
      subtitle: "Discover seamless travel planning",
      assetPath: "assets/images/hero/journey.webp",
      isVideo: false,
    ),
    StoryPanel(
      title: "Solutions at Your Fingertips",
      subtitle: "Technology that simplifies your experience",
      assetPath: "assets/images/hero/tech_solutions.jpg",
      isVideo: false,
    ),
    StoryPanel(
      title: "Home Away From Home",
      subtitle: "Comfort in every destination",
      assetPath: "assets/images/hero/home.jpg",
      isVideo: false,
    ),
    StoryPanel(
      title: "Creating Memories",
      subtitle: "Where every stay becomes an experience",
      assetPath: "assets/images/hero/memories.jpg",
      isVideo: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _initializeVideoControllers();
    _startAutoSlide();
  }

  Future<void> _initializeVideoControllers() async {
    for (var panel in _storyPanels) {
      if (panel.isVideo) {
        final controller = VideoPlayerController.asset(panel.assetPath);
        _videoControllers.add(controller);
        await controller.initialize();
        controller.setVolume(0.0);
        controller.setLooping(true);
      } else {
        _videoControllers.add(VideoPlayerController.asset("")); // placeholder
      }
    }
    if (mounted) setState(() {});
  }

  void _startAutoSlide() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        final nextPage = (_currentPage + 1) % _storyPanels.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
        _startAutoSlide();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (var controller in _videoControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
                // Pause all videos except current
                for (int i = 0; i < _videoControllers.length; i++) {
                  if (_storyPanels[i].isVideo) {
                    if (i == page) {
                      _videoControllers[i].play();
                    } else {
                      _videoControllers[i].pause();
                    }
                  }
                }
              });
            },
            itemCount: _storyPanels.length,
            itemBuilder: (context, index) {
              return AnimatedStoryPanel(
                storyPanel: _storyPanels[index],
                isActive: _currentPage == index,
                videoController: _storyPanels[index].isVideo ? _videoControllers[index] : null,
              );
            },
          ),
          // Page indicators
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _storyPanels.length,
                    (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentPage == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StoryPanel {
  final String title;
  final String subtitle;
  final String assetPath;
  final bool isVideo;

  StoryPanel({
    required this.title,
    required this.subtitle,
    required this.assetPath,
    required this.isVideo,
  });
}

class AnimatedStoryPanel extends StatelessWidget {
  final StoryPanel storyPanel;
  final bool isActive;
  final VideoPlayerController? videoController;

  const AnimatedStoryPanel({
    Key? key,
    required this.storyPanel,
    required this.isActive,
    this.videoController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background media
        storyPanel.isVideo && videoController != null
            ? VideoPlayer(videoController!)
            : Image.asset(
          storyPanel.assetPath,
          fit: BoxFit.cover,
        ),
        // Gradient overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
        ),
        // Content
        Center(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: isActive ? 1.0 : 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 500),
                  style: TextStyle(
                    fontSize: isActive ? 48 : 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  child: Text(storyPanel.title),
                ),
                const SizedBox(height: 16),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 500),
                  style: TextStyle(
                    fontSize: isActive ? 24 : 18,
                    color: Colors.white.withOpacity(0.8),
                  ),
                  child: Text(storyPanel.subtitle),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
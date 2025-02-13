// lib/features/home/widgets/services_narrative.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';


class ServicesNarrative extends StatefulWidget {
  const ServicesNarrative({Key? key}) : super(key: key);

  @override
  State<ServicesNarrative> createState() => _ServicesNarrativeState();
}

class _ServicesNarrativeState extends State<ServicesNarrative> {
  final Map<String, bool> _visibleServices = {};

  final List<ServiceData> _services = [
    ServiceData(
      title: 'Tours,Travels and Adventures',
      description: 'From Dreams to Destinations',
      features: [
        'Interactive journey planner',
        'Virtual tour previews',
        'Customized itineraries',
        'Budget optimization',
      ],
      iconPath: 'assets/animations/lottie/travel_planning.json',
      externalLink: 'https://www.instagram.com/yoloafricans_',
    ),
    ServiceData(
      title: 'Hospitality Solutions and Partnerships',
      description: 'Your Home Anywhere',
      features: [
        'Property showcases',
        'Virtual room tours',
        'Amenity comparison',
        'Location insights',
      ],
      iconPath: 'assets/animations/lottie/accommodation.json',
      externalLink: 'https://mybcloud.com/',
    ),
    ServiceData(
      title: 'Technology Integrations & Solutions',
      description: 'Technology that Travels',
      features: [
        'Booking platform demos',
        'Mobile app features',
        'API integration',
        'Real-time updates',
      ],
      iconPath: 'assets/animations/lottie/tech_integration.json',
      externalLink: 'https://paperlessenv.app/',
    ),
    ServiceData(
      title: 'Transportation, Logistics & Warehousing',
      description: 'Crafting Memorable Moments',
      features: [
        'Local activity planning',
        'Cultural experiences',
        'Special event access',
        'Personalized recommendations',
      ],
      iconPath: 'assets/animations/lottie/experience.json',
      externalLink: 'https://bx.bubblehousebiz.com/',
    ),
    ServiceData(
      title: 'Cleaning Services and Remodeling',
      description: 'Seamless Corporate Solutions',
      features: [
        'Corporate account management',
        'Expense tracking',
        'Meeting space booking',
        'Travel policy compliance',
      ],
      iconPath: 'assets/animations/lottie/business_travel.json',
      externalLink: 'https://ggpc.bubblehousebiz.com/',
    ),
  ];

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
      webOnlyWindowName: '_blank', // Adds nofollow for web
    )) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not launch $url'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    for (var service in _services) {
      _visibleServices[service.title] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 24),
      child: Column(
        children: [
          Text(
            'Our Brands',
            style: Theme.of(context).textTheme.displaySmall,
          ).animate().fadeIn(duration: 600.ms),
          const SizedBox(height: 16),
          Text(
            'Comprehensive solutions for modern travel needs',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              return constraints.maxWidth > 800
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
      children: _services
          .map((service) => SizedBox(
        width: 380,
        child: _buildServiceCard(service),
      ))
          .toList(),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: _services.map((service) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: _buildServiceCard(service),
        );
      }).toList(),
    );
  }

  Widget _buildServiceCard(ServiceData service) {
    return VisibilityDetector(
      key: Key(service.title),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 &&
            _visibleServices[service.title] == false) {
          setState(() {
            _visibleServices[service.title] = true;
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
              // Add Lottie animation
              SizedBox(
                height: 160,
                child: Center(
                  child: Lottie.asset(
                    service.iconPath,
                    animate: _visibleServices[service.title] ?? false,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                service.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ).animate(
                autoPlay: true, // Add autoPlay parameter
                target: _visibleServices[service.title] ?? false ? 1.0 : 0.0,
              ).fadeIn(delay: 300.ms),
              const SizedBox(height: 8),
              Text(
                service.description,
                style: Theme.of(context).textTheme.titleLarge,
              ).animate(
                autoPlay: true,
                target: _visibleServices[service.title] ?? false ? 1.0 : 0.0,
              ).fadeIn(delay: 400.ms),
              const SizedBox(height: 24),
              ...service.features.asMap().entries.map((entry) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        entry.value,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ).animate(
                autoPlay: true,
                target: _visibleServices[service.title] ?? false ? 1.0 : 0.0,
              ).fadeIn(
                delay: Duration(milliseconds: 500 + (entry.key * 100)),
              )),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _launchURL(service.externalLink),
                  child: const Text('Learn More'),
                ),
              ).animate(
                autoPlay: true,
                target: _visibleServices[service.title] ?? false ? 1.0 : 0.0,
              ).fadeIn(delay: 700.ms),
            ],
          ),
        ),
      ).animate(
        autoPlay: true,
        target: _visibleServices[service.title] ?? false ? 1.0 : 0.0,
      ).scale(
        duration: 600.ms,
        curve: Curves.easeOut,
      ),
    );
  }
}

class ServiceData {
  final String title;
  final String description;
  final List<String> features;
  final String iconPath;
  final String externalLink;

  ServiceData({
    required this.title,
    required this.description,
    required this.features,
    required this.iconPath,
    required this.externalLink,
  });
}
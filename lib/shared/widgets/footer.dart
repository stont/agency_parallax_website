import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        return Container(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          padding: EdgeInsets.all(isMobile ? 24 : 48),
          width: double.infinity,
          child: isMobile
              ? _buildMobileLayout(context)
              : _buildDesktopLayout(context),
        );
      },
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _buildCompanyInfo(context),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: _buildQuickLinks(context),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: _buildServices(context),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: _buildContactInfo(context),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCompanyInfo(context),
          const SizedBox(height: 32),
          Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
            ),
            child: Column(
              children: [
                ExpansionTile(
                  title: const Text('Quick Links'),
                  children: _buildQuickLinksList(context),
                ),
                ExpansionTile(
                  title: const Text('Services'),
                  children: _buildServicesList(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildContactInfo(context),
          const SizedBox(height: 32),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Widget _buildCompanyInfo(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Bubble House',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Transforming travel experiences through innovative solutions and personalized service.',
            style: TextStyle(height: 1.6),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 16,
            children: [
              _buildSocialIcon(
                FontAwesomeIcons.linkedin,
                'https://linkedin.com/company/bubble-house',
              ),
              _buildSocialIcon(
                FontAwesomeIcons.envelope,
                'mailto:contact@bubblehouse.com',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickLinks(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Quick Links',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ..._buildQuickLinksList(context),
      ],
    );
  }

  List<Widget> _buildQuickLinksList(BuildContext context) {
    final links = {
      'Home': '/',
      'About Us': '/about',
      'Our Team': '/team',
      'Testimonials': '/testimonials',
      'Contact': '/contact',
    };

    return links.entries.map((entry) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: InkWell(
          onTap: () {
            // Add navigation logic here
          },
          child: Text(
            entry.key,
            style: const TextStyle(height: 1.6),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildServices(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Services',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ..._buildServicesList(context),
      ],
    );
  }

  List<Widget> _buildServicesList(BuildContext context) {
    final services = [
      'Travel Planning',
      'Accommodation',
      'Tech Integration',
      'Customer Support',
    ];

    return services.map((service) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          service,
          style: const TextStyle(height: 1.6),
        ),
      );
    }).toList();
  }

  Widget _buildContactInfo(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Contact Us',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildContactItem(
            FontAwesomeIcons.locationDot,
            'US Operation Office\nATL, Johnboro, Georgia',
          ),
          const SizedBox(height: 16),
          _buildContactItem(
            FontAwesomeIcons.locationDot,
            'Nigeria HQ\n38 Opebi Street, Lagos',
          ),
          const SizedBox(height: 16),
          _buildContactItem(
            FontAwesomeIcons.locationDot,
            'NG Operational HQ\n4 Iyaganku Street, Ibadan',
          ),
          const SizedBox(height: 12),
          _buildContactItem(
            FontAwesomeIcons.envelope,
            'contact@bubblehousebiz.com',
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        FaIcon(icon, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(height: 1.6),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return InkWell(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      child: FaIcon(
        icon,
        size: 24,
      ),
    );
  }
}

  Widget _buildBottomBar(BuildContext context) {
    final currentYear = DateTime.now().year;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(),
        const SizedBox(height: 16),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 24,
          runSpacing: 8,
          children: [
            Text('© $currentYear Bubble House. All rights reserved.'),
            const Text('Privacy Policy'),
            const Text('Terms of Service'),
          ],
        ),
      ],
    );
  }

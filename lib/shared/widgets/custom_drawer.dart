// lib/shared/widgets/custom_drawer.dart
import 'package:flutter/material.dart';
import '../../core/services/scroll_service.dart';

class CustomDrawer extends StatelessWidget {
  final ScrollController scrollController;

  const CustomDrawer({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bubble House',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Travel Experience Solutions',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(
              context: context,
              title: 'Home',
              onTap: () => _handleNavigation(context, 'home'),
            ),
            _buildDrawerItem(
              context: context,
              title: 'About Us',
              onTap: () => _handleNavigation(context, 'about'),
            ),
            _buildDrawerItem(
              context: context,
              title: 'Services',
              onTap: () => _handleNavigation(context, 'services'),
            ),
            _buildDrawerItem(
              context: context,
              title: 'Team',
              onTap: () => _handleNavigation(context, 'team'),
            ),
            _buildDrawerItem(
              context: context,
              title: 'Testimonials',
              onTap: () => _handleNavigation(context, 'testimonials'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      onTap: onTap,
    );
  }

  void _handleNavigation(BuildContext context, String section) {
    Navigator.pop(context); // Close drawer
    ScrollService.scrollToSection(section, scrollController);
  }
}
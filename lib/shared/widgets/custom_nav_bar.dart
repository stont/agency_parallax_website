// lib/shared/widgets/custom_nav_bar.dart
import 'package:flutter/material.dart';
import '../../core/services/scroll_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomNavBar extends StatelessWidget implements PreferredSizeWidget {
  final ScrollController scrollController;

  const CustomNavBar({
    super.key,
    required this.scrollController,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        return AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          title: const Text(
            'Bubble House',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: isMobile
              ? [
            Builder(
              builder: (context) => IconButton(
                icon: const FaIcon(FontAwesomeIcons.bars),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
            ),
          ]
              : _buildDesktopMenu(context),
        );
      },
    );
  }

  List<Widget> _buildDesktopMenu(BuildContext context) {
    final menuItems = [
      'Home',
      'About Us',
      'Services',
      'Team',
      'Testimonials',
    ];

    return menuItems.map((item) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextButton(
          onPressed: () => ScrollService.scrollToSection(
            item.toLowerCase().replaceAll(' ', ''),
            scrollController,
          ),
          child: Text(
            item,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }).toList();
  }
}
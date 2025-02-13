import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class FloatingContactButtons extends StatefulWidget {
  const FloatingContactButtons({super.key});

  @override
  State<FloatingContactButtons> createState() => _FloatingContactButtonsState();
}

class _FloatingContactButtonsState extends State<FloatingContactButtons>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  Future<void> _launchWhatsApp() async {
    // Replace with your WhatsApp number
    const whatsappUrl = 'https://wa.me/2349167026000';
    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl));
    }
  }

  Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'info@bubblehouse.com',
      queryParameters: {
        'subject': 'Contact from Website',
      },
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16,
      bottom: 16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ScaleTransition(
            scale: CurvedAnimation(
              parent: _controller,
              curve: Curves.easeOut,
            ),
            child: FloatingActionButton(
              heroTag: 'email',
              backgroundColor: Colors.red,
              mini: true,
              onPressed: _launchEmail,
              child: const FaIcon(FontAwesomeIcons.envelope),
            ),
          ),
          const SizedBox(height: 8),
          ScaleTransition(
            scale: CurvedAnimation(
              parent: _controller,
              curve: Curves.easeOut,
            ),
            child: FloatingActionButton(
              heroTag: 'whatsapp',
              backgroundColor: Colors.green,
              mini: true,
              onPressed: _launchWhatsApp,
              child: const FaIcon(FontAwesomeIcons.whatsapp),
            ),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'toggle',
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: _toggleExpanded,
            child: AnimatedRotation(
              duration: const Duration(milliseconds: 300),
              turns: _isExpanded ? 0.125 : 0,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
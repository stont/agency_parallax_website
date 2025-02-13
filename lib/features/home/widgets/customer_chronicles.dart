// lib/features/home/widgets/customer_chronicles.dart
import 'package:flutter/material.dart';
import '../../../shared/models/testimonial.dart';
import '../controllers/testimonial_controller.dart';

class CustomerChronicles extends StatefulWidget {
  const CustomerChronicles({super.key});

  @override
  State<CustomerChronicles> createState() => _CustomerChroniclesState();
}

class _CustomerChroniclesState extends State<CustomerChronicles> {
  late final TestimonialController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TestimonialController();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Customer Chronicles',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Real Stories, Real Impact',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              isSmallScreen
                  ? _buildMobileLayout()
                  : _buildDesktopLayout(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side - Testimonial Navigation
        Expanded(
          flex: 1,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _controller.testimonials.length,
            itemBuilder: (context, index) {
              return TestimonialTab(
                testimonial: _controller.testimonials[index],
                isSelected: _selectedIndex == index,
                onTap: () => setState(() => _selectedIndex = index),
              );
            },
          ),
        ),
        const SizedBox(width: 32),
        // Right side - Detailed Story
        Expanded(
          flex: 2,
          child: TestimonialStory(
            testimonial: _controller.testimonials[_selectedIndex],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        // Testimonial Carousel
        SizedBox(
          height: 500, // Increased height to accommodate content
          child: PageView.builder(
            onPageChanged: (index) => setState(() => _selectedIndex = index),
            itemCount: _controller.testimonials.length,
            itemBuilder: (context, index) {
              return SingleChildScrollView( // Added ScrollView to handle overflow
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TestimonialStory(
                    testimonial: _controller.testimonials[index],
                    isMobile: true, // New parameter to adjust layout
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        // Page Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _controller.testimonials.length,
                (index) =>
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: CircleAvatar(
                    radius: 4,
                    backgroundColor: _selectedIndex == index
                        ? Theme
                        .of(context)
                        .primaryColor
                        : Colors.grey,
                  ),
                ),
          ),
        ),
      ],
    );
  }
}

class TestimonialTab extends StatelessWidget {
  final Testimonial testimonial;
  final bool isSelected;
  final VoidCallback onTap;

  const TestimonialTab({
    super.key,
    required this.testimonial,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade300,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              testimonial.customerName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              testimonial.shortDescription,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TestimonialStory extends StatelessWidget {
  final Testimonial testimonial;
  final bool isMobile;

  const TestimonialStory({
    super.key,
    required this.testimonial,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Customer Info
            if (isMobile)
              _buildMobileCustomerInfo()
            else
              _buildDesktopCustomerInfo(),
            const SizedBox(height: 24),
            // Before & After
            if (isMobile)
              _buildMobileBeforeAfter()
            else
              _buildDesktopBeforeAfter(),
            const SizedBox(height: 24),
            // Full Story
            Text(
              testimonial.fullStory,
              style: TextStyle(
                fontSize: isMobile ? 13 : 14,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 16),
            // Impact Metrics
            if (testimonial.impactMetrics != null) ...[
              const Divider(),
              const SizedBox(height: 16),
              Text(
                'Impact Metrics',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              _buildImpactMetrics(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMobileCustomerInfo() {
    return Column(
      children: [
        CircleAvatar(
          radius: 25, // Smaller radius for mobile
          backgroundImage: AssetImage(testimonial.customerImage),
        ),
        const SizedBox(height: 8),
        Text(
          testimonial.customerName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          testimonial.location,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopCustomerInfo() {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(testimonial.customerImage),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                testimonial.customerName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                testimonial.location,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileBeforeAfter() {
    return Column(
      children: [
        _buildBeforeAfter(
          'Before',
          testimonial.beforeSituation,
          Colors.red.shade100,
        ),
        const SizedBox(height: 12),
        _buildBeforeAfter(
          'After',
          testimonial.afterSituation,
          Colors.green.shade100,
        ),
      ],
    );
  }

  Widget _buildDesktopBeforeAfter() {
    return Row(
      children: [
        Expanded(
          child: _buildBeforeAfter(
            'Before',
            testimonial.beforeSituation,
            Colors.red.shade100,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildBeforeAfter(
            'After',
            testimonial.afterSituation,
            Colors.green.shade100,
          ),
        ),
      ],
    );
  }

  Widget _buildImpactMetrics() {
    return Wrap(
      spacing: 8, // Reduced spacing for mobile
      runSpacing: 8,
      children: testimonial.impactMetrics!.map((metric) {
        return Chip(
          label: Text(
            metric,
            style: TextStyle(fontSize: isMobile ? 12 : 14),
          ),
          backgroundColor: Colors.blue.withOpacity(0.1),
          padding: EdgeInsets.zero,
        );
      }).toList(),
    );
  }

  Widget _buildBeforeAfter(String title, String content, Color backgroundColor) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isMobile ? 13 : 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(fontSize: isMobile ? 11 : 12),
          ),
        ],
      ),
    );
  }
}

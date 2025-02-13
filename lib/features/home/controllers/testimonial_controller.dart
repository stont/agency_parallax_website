// lib/features/home/controllers/testimonial_controller.dart
import '../../../shared/models/testimonial.dart';
import '../../../core/constants/assets_path.dart';

class TestimonialController {
  final List<Testimonial> testimonials = [
    Testimonial(
      customerName: 'John & Emily Davidson',
      customerImage: AssetsPath.testimonialImage1,
      location: 'New York, USA',
      shortDescription: 'Family Vacation Transformation',
      beforeSituation: 'Struggled with planning family trips around school schedules and diverse interests.',
      afterSituation: 'Seamless vacation planning with perfect activities for everyone.',
      fullStory: 'As a family of five with children of different ages, planning vacations was always a challenge. Bubble House transformed our experience by providing personalized itineraries that considered everyone\'s interests and schedule constraints. Their AI-driven recommendations helped us discover activities we never would have found on our own.',
      impactMetrics: [
        '40% less planning time',
        '100% family satisfaction',
        'Saved \$2000 on bookings'
      ],
    ),
    Testimonial(
      customerName: 'Sarah Chen',
      customerImage: AssetsPath.testimonialImage1,
      location: 'Singapore',
      shortDescription: 'Business Travel Made Simple',
      beforeSituation: 'Complex corporate travel arrangements with frequent changes.',
      afterSituation: 'Streamlined booking process with flexible modification options.',
      fullStory: 'Managing business travel for our team was becoming a full-time job in itself. The integrated booking platform and real-time updates from Bubble House have made it incredibly efficient. What used to take hours now takes minutes, and the cost-saving analytics have been invaluable for our finance team.',
      impactMetrics: [
        '75% reduction in booking time',
        '30% cost savings',
        'Zero booking errors'
      ],
    ),
    Testimonial(
      customerName: 'Gloria Olutunmbi',
      customerImage: AssetsPath.testimonialImage1,
      location: 'Singapore',
      shortDescription: 'Business Travel Made Simple',
      beforeSituation: 'Complex corporate travel arrangements with frequent changes.',
      afterSituation: 'Streamlined booking process with flexible modification options.',
      fullStory: 'Managing business travel for our team was becoming a full-time job in itself. The integrated booking platform and real-time updates from Bubble House have made it incredibly efficient. What used to take hours now takes minutes, and the cost-saving analytics have been invaluable for our finance team.',
      impactMetrics: [
        '75% reduction in booking time',
        '30% cost savings',
        'Zero booking errors'
      ],
    ),
    // Add more testimonials as needed
  ];
}
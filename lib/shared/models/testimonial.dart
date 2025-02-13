// lib/shared/models/testimonial.dart
class Testimonial {
  final String customerName;
  final String customerImage;
  final String location;
  final String shortDescription;
  final String beforeSituation;
  final String afterSituation;
  final String fullStory;
  final List<String>? impactMetrics;

  Testimonial({
    required this.customerName,
    required this.customerImage,
    required this.location,
    required this.shortDescription,
    required this.beforeSituation,
    required this.afterSituation,
    required this.fullStory,
    this.impactMetrics,
  });
}
// lib/shared/models/team_member.dart
class TeamMember {
  final String name;
  final String position;
  final String imageUrl;
  final String bio;
  final String successStory;
  final List<String>? skills;      // Optional skills list
  final String? linkedInUrl;       // Optional LinkedIn profile
  final String? emailContact;      // Optional email contact

  TeamMember({
    required this.name,
    required this.position,
    required this.imageUrl,
    required this.bio,
    required this.successStory,
    this.skills,
    this.linkedInUrl,
    this.emailContact,
  });

  // Factory constructor to create TeamMember from JSON
  factory TeamMember.fromJson(Map<String, dynamic> json) {
    return TeamMember(
      name: json['name'] ?? '',
      position: json['position'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      bio: json['bio'] ?? '',
      successStory: json['successStory'] ?? '',
      skills: List<String>.from(json['skills'] ?? []),
      linkedInUrl: json['linkedInUrl'],
      emailContact: json['emailContact'],
    );
  }

  // Convert TeamMember to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'position': position,
      'imageUrl': imageUrl,
      'bio': bio,
      'successStory': successStory,
      'skills': skills,
      'linkedInUrl': linkedInUrl,
      'emailContact': emailContact,
    };
  }
}
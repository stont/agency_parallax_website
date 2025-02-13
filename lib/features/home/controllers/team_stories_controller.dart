// lib/features/home/controllers/team_stories_controller.dart
import '../../../shared/models/team_member.dart';

class TeamStoriesController {
  final List<TeamMember> teamMembers = [
    TeamMember(
      name: 'Sarah Johnson',
      position: 'Travel Solutions Architect',
      imageUrl: 'assets/images/team/team_member_1.jpg',
      bio: 'With over 10 years in travel technology, Sarah specializes in creating seamless travel experiences through innovative solutions.',
      successStory: 'Implemented an AI-driven recommendation system that increased customer satisfaction by 45%.',
    ),
    TeamMember(
      name: 'Michael Chen',
      position: 'Customer Experience Lead',
      imageUrl: 'assets/images/team/team_member_2.jpg',
      bio: 'Michael brings 8 years of expertise in customer service and experience design to ensure every journey is memorable.',
      successStory: 'Developed a new customer feedback system that improved response time by 60%.',
    ),
    // Add more team members as needed
  ];
}


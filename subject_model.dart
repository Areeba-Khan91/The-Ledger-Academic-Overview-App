import 'package:flutter/material.dart';

class Subject {
  final String name;
  final String courseCode;
  final String description;
  final List<String> objectives;
  final List<Map<String, String>> scheduleDetails;
  final String instructorName;
  final String instructorTitle;
  final String nextSessionTopic;
  final String nextSessionDate;
  final double progress;
  final IconData icon;
  final Color color;
  final String imageUrl; // ADDED THIS LINE TO FIX YOUR ERROR

  Subject({
    required this.name,
    required this.courseCode,
    required this.description,
    required this.objectives,
    required this.scheduleDetails,
    required this.instructorName,
    required this.instructorTitle,
    required this.nextSessionTopic,
    required this.nextSessionDate,
    required this.progress,
    required this.icon,
    required this.color,
    required this.imageUrl, // ADDED THIS LINE
  });
}
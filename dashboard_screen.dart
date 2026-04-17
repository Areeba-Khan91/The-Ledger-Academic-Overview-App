import 'package:flutter/material.dart';
import '../models/subject_model.dart';
import '../controllers/auth_controller.dart';
import 'detail_screen.dart';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Subject> subjects = [
    Subject(
      name: "Mobile App Development", courseCode: "COURSE CS-402", progress: 0.75, icon: Icons.phone_android, color: const Color(0xFF0047AB),
      imageUrl: "https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=600",
      description: "This mobile application development course provides a comprehensive, hands-on foundation for building Android and iOS applications using modern frameworks like Flutter (Dart) or React Native. Participants learn UI/UX design, API integration, database management, and app deployment to app stores, aiming to create functional, industry-standard mobile apps. ",
      objectives: ["Understanding Android Studio, Xcode, and mobile OS ecosystems.","Focus on Dart (for Flutter), Kotlin/Java (for Android), or JavaScript (for React Native).",
      "Creating intuitive user interfaces, implementing layouts, and managing application state.","Utilizing Firebase, API integration, data persistence, and user authentication."],
      scheduleDetails: [{"day": "Mondays", "room": "Lab 402", "time": "10:00 AM"}, {"day": "Wednesdays", "room": "Hall B", "time": "10:00 AM"}],
      instructorName: "Dr. Elias Thorne", instructorTitle: "Senior Architect",
      nextSessionTopic: "Architectural Design", nextSessionDate: "Mon, Oct 24 • 10:00 AM",
    ),
    Subject(
      name: "Software Re-engineering", courseCode: "COURSE CS-501", progress: 0.32, icon: Icons.settings_backup_restore, color: const Color(0xFF5A5A5A),
      imageUrl: "https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=600",
      description: "A software engineering course is an academic or professional program that teaches the systematic design, development, testing, and maintenance of software systems. It focuses on applying engineering principles to create reliable, efficient, and scalable applications, covering programming, software architecture, and project management. ",
      objectives: ["Studies typically include programming languages (like Python, Java, C++), data structures, algorithms, database management, and software testing.",
      "Students learn the entire process from requirements analysis to deployment and maintenance.",
      "Software engineering differs from pure computer science by emphasizing the engineering approach, user requirements, and practical application, often involving coursework in Agile methodology, Devops, and software architecture."," Ensuring software is bug-free and efficient."],
      scheduleDetails: [{"day": "Tuesdays", "room": "Lab 101", "time": "02:30 PM"}],
      instructorName: "Prof. Sarah Miller", instructorTitle: "Systems Specialist",
      nextSessionTopic: "Legacy Analysis", nextSessionDate: "Tue, Oct 25 • 02:30 PM",
    ),
    Subject(
      name: "MIS", courseCode: "COURSE CS-305", progress: 0.50, icon: Icons.storage, color: const Color(0xFF5A5A5A),
      imageUrl: "https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=600",
      description: "A Management Information Systems (MIS) course explores the intersection of people, technology, and business processes. It teaches students to leverage information technology (IT)—such as databases, networks, and software—to solve business problems, enhance decision-making, and gain competitive advantage. Key topics include database design, system analysis, e-commerce, and security.",
      objectives: ["Understanding how companies use technology to improve operations and achieve strategic goals.",
      "Designing database applications to store, organize, and retrieve information.",
      "Analyzing business needs to design effective technological solutions.",
      " Addressing data protection, information security, and ethical issues in the information age. "],
      scheduleDetails: [{"day": "Fridays", "room": "Hall A", "time": "09:00 AM"}],
      instructorName: "Dr. Robert Vance", instructorTitle: "Data Strategist",
      nextSessionTopic: "Data Management", nextSessionDate: "Fri, Oct 28 • 09:00 AM",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Row(children: [
                          Container(width: 40, height: 40, decoration: BoxDecoration(color: const Color(0xFFE8EFFF), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.account_balance, color: Color(0xFF0047AB), size: 20)),
                          const SizedBox(width: 12),
                          const Text("The Ledger", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
                        ]),
                        IconButton(icon: const Icon(Icons.logout, color: Color(0xFF0047AB)), onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const LoginScreen()))),
                      ]),
                      const SizedBox(height: 30),
                      const Text("ACADEMIC OVERVIEW", style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
                      Text(
                      "Welcome, ${AuthController.loggedInUser?.name ?? 'Guest'}!", 
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)
                      ),
                      const SizedBox(height: 20),
                      SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [_stat("GPA", "3.88", true), _stat("CREDITS", "18", false), _stat("RANK", "Top 5%", false)])),
                      const SizedBox(height: 30),
                      const Text("Current Subjects", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 15),
                      ...subjects.map((s) => _subjectCard(s)),
                    ],
                  ),
                ),
              ),
              _bottomNav(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stat(String l, String v, bool b) => Container(width: 120, margin: const EdgeInsets.only(right: 15), padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: b ? const Border(left: BorderSide(color: Color(0xFF8B0000), width: 2)) : null), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(l, style: const TextStyle(fontSize: 10, color: Colors.grey)), Text(v, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0047AB)))]));
  
  Widget _subjectCard(Subject s) => GestureDetector(
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => DetailScreen(subject: s))),
    child: Container(margin: const EdgeInsets.only(bottom: 15), padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25), border: Border(left: BorderSide(color: s.color, width: 4))), child: Column(children: [Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(s.name, style: const TextStyle(fontWeight: FontWeight.bold)), Text(s.scheduleDetails[0]['time']!, style: const TextStyle(fontSize: 12, color: Colors.grey))]), Icon(s.icon, color: const Color(0xFF0047AB))]), const SizedBox(height: 15), LinearProgressIndicator(value: s.progress, color: const Color(0xFF0047AB), backgroundColor: Colors.grey.shade100)])),
  );

  Widget _bottomNav() => Container(padding: const EdgeInsets.all(15), color: Colors.white, child: const Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [Icon(Icons.grid_view_rounded, color: Color(0xFF0047AB)), Icon(Icons.book, color: Colors.grey), Icon(Icons.bar_chart, color: Colors.grey), Icon(Icons.person, color: Colors.grey)]));
}
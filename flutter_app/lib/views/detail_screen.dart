import 'package:flutter/material.dart';
import '../models/subject_model.dart';

class DetailScreen extends StatelessWidget {
  final Subject subject;
  const DetailScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(decoration: BoxDecoration(color: const Color(0xFFE8EFFF), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.account_balance, color: Color(0xFF0047AB), size: 18)),
        ),
        title: const Text("The Ledger", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [IconButton(icon: const Icon(Icons.share_outlined, color: Color(0xFF0047AB)), onPressed: () {})],
      ),
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
                      Text(subject.name, style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold, height: 1.1)),
                      const SizedBox(height: 15),
                      Row(children: [
                        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: const Color(0xFFF9DEDC), borderRadius: BorderRadius.circular(10)), child: Text(subject.courseCode, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF410002)))),
                        const SizedBox(width: 15),
                        const Icon(Icons.people_outline, size: 16, color: Colors.grey),
                        const Text(" 42 Enrolled", style: TextStyle(color: Colors.grey, fontSize: 13))
                      ]),
                      const SizedBox(height: 30),
                      Stack(clipBehavior: Clip.none, children: [
                        ClipRRect(borderRadius: BorderRadius.circular(25), child: Image.network(subject.imageUrl, height: 200, width: double.infinity, fit: BoxFit.cover)),
                        Positioned(bottom: -30, right: 20, child: Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: const Border(left: BorderSide(color: Color(0xFF8B0000), width: 3)), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)]), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text("NEXT SESSION", style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFF8B0000))), Text(subject.nextSessionTopic, style: const TextStyle(fontWeight: FontWeight.bold)), Text(subject.nextSessionDate, style: const TextStyle(fontSize: 10, color: Colors.grey))]))),
                      ]),
                      const SizedBox(height: 50),
                      const Text("Description", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text(subject.description, style: const TextStyle(color: Color(0xFF4A4A4A), height: 1.5)),
                      const SizedBox(height: 25),
                      const Text("Learning Objectives", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      ...subject.objectives.map((obj) => Padding(padding: const EdgeInsets.symmetric(vertical: 5), child: Row(children: [const Icon(Icons.circle, size: 6, color: Color(0xFF0047AB)), const SizedBox(width: 10), Expanded(child: Text(obj))]))),
                      const SizedBox(height: 30),
                      Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: const Color(0xFFF1F4FF), borderRadius: BorderRadius.circular(20)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        const Text("SCHEDULE DETAILS", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                        ...subject.scheduleDetails.map((s) => ListTile(contentPadding: EdgeInsets.zero, title: Text(s['day']!, style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: Text(s['room']!), trailing: Text(s['time']!, style: const TextStyle(color: Color(0xFF0047AB), fontWeight: FontWeight.bold)))),
                      ])),
                      const SizedBox(height: 25),
                      // Instructor Card (FIXED)
                      Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)), child: Row(children: [
                        const CircleAvatar(backgroundColor: Color(0xFFE8EFFF), radius: 25, child: Icon(Icons.person, color: Color(0xFF0047AB))),
                        const SizedBox(width: 15),
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text("INSTRUCTOR", style: TextStyle(fontSize: 10, color: Colors.grey)), Text(subject.instructorName, style: const TextStyle(fontWeight: FontWeight.bold)), Text(subject.instructorTitle, style: const TextStyle(color: Color(0xFF0047AB), fontSize: 12))])
                      ])),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
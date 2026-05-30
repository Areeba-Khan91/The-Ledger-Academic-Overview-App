import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../controllers/auth_controller.dart';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<dynamic> _courses = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final data = await ApiService.getCourses();
    setState(() { _courses = data.take(10).toList(); _loading = false; });
  }

void _dialog({dynamic item}) {
    final t = TextEditingController(text: item?['title'] ?? "");
    final b = TextEditingController(text: item?['body'] ?? "");
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, 
          left: 24, 
          right: 24, 
          top: 24
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item == null ? "Add New Course" : "Edit Course", 
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 20),
            TextField(
              controller: t, 
              decoration: InputDecoration(
                labelText: "Title", 
                filled: true, 
                fillColor: const Color(0xFFF1F4FF),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none)
              )
            ),
            const SizedBox(height: 15),
            TextField(
              controller: b, 
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Description", 
                filled: true, 
                fillColor: const Color(0xFFF1F4FF),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none)
              )
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0047AB),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                ),
                onPressed: () async {
                  if (t.text.isEmpty || b.text.isEmpty) return;

                  bool success = false;
                  if (item == null) {
                    // Create Logic
                    success = await ApiService.addCourse(t.text, b.text);
                    if (success) {
                      setState(() {
                        _courses.insert(0, {"id": 999, "title": t.text, "body": b.text});
                      });
                    }
                  } else {
                    // Update Logic
                    success = await ApiService.updateCourse(item['id'], t.text, b.text);
                    if (success) {
                      setState(() {
                        int i = _courses.indexWhere((c) => c['id'] == item['id']);
                        if (i != -1) {
                          _courses[i] = {"id": item['id'], "title": t.text, "body": b.text};
                        }
                      });
                    }
                  }

                  // THE FIX: Check if widget is still visible before popping
                  if (!mounted) return; 
                  Navigator.of(context).pop(); 
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(item == null ? "Course Added" : "Course Updated"))
                  );
                },
                child: const Text("Save Changes", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      floatingActionButton: FloatingActionButton(backgroundColor: const Color(0xFF0047AB), onPressed: () => _dialog(), child: const Icon(Icons.add, color: Colors.white)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: Column(children: [
            _header(),
            Expanded(child: _loading ? const Center(child: CircularProgressIndicator()) : ListView.builder(padding: const EdgeInsets.all(20), itemCount: _courses.length, itemBuilder: (c, i) => _card(_courses[i]))),
          ]),
        ),
      ),
    );
  }

  Widget _header() => Container(padding: const EdgeInsets.only(top: 60, left: 24, right: 24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(children: [Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFFE8EFFF), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.account_balance, color: Color(0xFF0047AB))), const SizedBox(width: 10), const Text("The Ledger", style: TextStyle(fontWeight: FontWeight.bold))]),
      IconButton(icon: const Icon(Icons.logout), onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const LoginScreen()))),
    ]),
    const SizedBox(height: 20),
    Text("Welcome, ${AuthController.loggedInUser?.name ?? 'Guest'}!", style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
  ]));

  Widget _card(dynamic item) => Container(
    margin: const EdgeInsets.only(bottom: 15), padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(child: Text(item['title'], style: const TextStyle(fontWeight: FontWeight.bold))),
        Row(children: [
          IconButton(icon: const Icon(Icons.edit, color: Colors.blue), onPressed: () => _dialog(item: item)),
          IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: () {
            setState(() => _courses.removeWhere((c) => c['id'] == item['id']));
          }),
        ]),
      ]),
      Text(item['body'], style: const TextStyle(color: Colors.grey, fontSize: 12)),
    ]),
  );
}
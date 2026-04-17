import 'package:flutter/material.dart';
import '../utils/validators.dart';
import '../controllers/auth_controller.dart';
import 'registration_screen.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool _isObscured = true;
  bool _rememberMe = false;

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      bool success = AuthController.loginUser(
        _emailController.text,
        _passController.text,
      );

      if (success) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color(0xFF8B0000), // Professional Dark Red
            content: Text("Authentication Failed: Account not found or invalid credentials."),
          ),
        );
      }
    }
  }

  Widget _fieldLabel(String text) {
    return Padding(padding: const EdgeInsets.only(bottom: 8, top: 20), child: Text(text.toUpperCase(), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF5A5A5A), letterSpacing: 1.2)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Row(children: const [Icon(Icons.account_balance, color: Color(0xFF0047AB), size: 30), SizedBox(width: 10), Text("The Ledger", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))]),
                    const SizedBox(height: 50),
                    const Text("Welcome back", style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold, letterSpacing: -1)),
                    const Text("Access your professional dashboard", style: TextStyle(fontSize: 16, color: Color(0xFF5A5A5A))),
                    const SizedBox(height: 40),
                    _fieldLabel("Corporate Email"),
                    TextFormField(controller: _emailController, decoration: _inputDecoration("name@firm.com"), validator: AppValidators.validateEmail),
                    _fieldLabel("Secure Password"),
                    TextFormField(
                      controller: _passController,
                      obscureText: _isObscured,
                      decoration: _inputDecoration("••••••••••••").copyWith(suffixIcon: IconButton(icon: Icon(_isObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: Colors.grey), onPressed: () => setState(() => _isObscured = !_isObscured))),
                      validator: (val) => (val == null || val.isEmpty) ? "Password required" : null,
                    ),
                    const SizedBox(height: 20),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Row(children: [
                        SizedBox(height: 24, width: 24, child: Checkbox(value: _rememberMe, onChanged: (val) => setState(() => _rememberMe = val!), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)))),
                        const SizedBox(width: 8), const Text("Remember session", style: TextStyle(fontSize: 14)),
                      ]),
                      TextButton(onPressed: () {}, child: const Text("Forgot Access?", style: TextStyle(color: Color(0xFF0047AB), fontWeight: FontWeight.bold))),
                    ]),
                    const SizedBox(height: 30),
                    SizedBox(width: double.infinity, height: 60, child: ElevatedButton(onPressed: _handleLogin, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0047AB), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), elevation: 0), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: const [Text("Authenticate", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), SizedBox(width: 10), Icon(Icons.arrow_forward, color: Colors.white, size: 20)]))),
                    const SizedBox(height: 40),
                    const Divider(color: Color(0xFFEEEEEE)),
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    const SizedBox(height: 50),
                    Center(child: Column(children: [
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        const Text("New to the institution? "),
                        GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RegistrationScreen())), child: const Text("Apply for Account", style: TextStyle(color: Color(0xFF8B0000), fontWeight: FontWeight.bold))),
                      ]),
                      const SizedBox(height: 20),
                      Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1), borderRadius: BorderRadius.circular(20)), child: Row(mainAxisSize: MainAxisSize.min, children: const [Icon(Icons.circle, color: Colors.green, size: 8), SizedBox(width: 8), Text("SYSTEM SECURE", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey))])),
                    ])),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) => InputDecoration(hintText: hint, fillColor: const Color(0xFFF1F4FF), filled: true, errorStyle: const TextStyle(color: Color(0xFF8B0000)), border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none), contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18));
  Widget _socialButton(String label, IconData icon, Color iconColor) => OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 15), side: const BorderSide(color: Color(0xFFF0F0F0)), backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: iconColor), const SizedBox(width: 8), Text(label, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))]));
}
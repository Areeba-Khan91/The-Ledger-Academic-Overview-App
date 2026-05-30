import 'package:flutter/material.dart';
import '../utils/validators.dart';
import '../utils/enums.dart';
import '../controllers/auth_controller.dart'; // Import added

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();
  
  Gender? _selectedGender;
  bool _isObscured = true;
  bool hasSixChars = false;
  bool hasUppercase = false;
  bool hasSpecialChar = false;

  @override
  void initState() {
    super.initState();
    _passController.addListener(_checkPassword);
  }

  void _checkPassword() {
    final val = _passController.text;
    setState(() {
      hasSixChars = val.length >= 6;
      hasUppercase = val.contains(RegExp(r'[A-Z]'));
      hasSpecialChar = val.contains(RegExp(r'[!@#$%^&*(),.?":{}|<> ]'));
    });
  }

  @override
  void dispose() {
    _passController.removeListener(_checkPassword);
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  void _handleRegistration() {
    if (_formKey.currentState!.validate()) {
      // Save user to AuthController
      AuthController.registerUser(
        _nameController.text,
        _emailController.text,
        _passController.text,
      );
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration Successful! Please login.")),
      );
      Navigator.pop(context); // Go back to login
    }
  }

  Widget _fieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 16),
      child: Text(text.toUpperCase(), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF5A5A5A), letterSpacing: 1.2)),
    );
  }

  Widget _buildRequirement(String text, bool isMet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(isMet ? Icons.check_circle : Icons.circle, size: 16, color: isMet ? const Color(0xFF0047AB) : Colors.grey.shade400),
          const SizedBox(width: 10),
          Text(text, style: TextStyle(color: isMet ? const Color(0xFF0047AB) : const Color(0xFF5A5A5A), fontSize: 13)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, height: double.infinity,
        decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFFE8EFFF), Color(0xFFF8FAFF)])),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450), 
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      Row(children: [
                        Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFF0047AB), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.account_balance_wallet, color: Colors.white, size: 24)),
                        const SizedBox(width: 12),
                        const Text("The Ledger", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      ]),
                      const SizedBox(height: 30),
                      const Text("Create account", style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, letterSpacing: -1)),
                      const SizedBox(height: 8),
                      const Text("Join the architectural standard of professional finance.", style: TextStyle(fontSize: 15, color: Color(0xFF5A5A5A))),
                      const SizedBox(height: 35),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 10))]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _fieldLabel("Full Name"),
                            _buildTextField(_nameController, "Enter your legal name", AppValidators.validateName),
                            _fieldLabel("Email Address"),
                            _buildTextField(_emailController, "name@firm.com", AppValidators.validateEmail),
                            _fieldLabel("Gender Identity"),
                            DropdownButtonFormField<Gender>(
                              decoration: _inputDecoration("Select an option"),
                              items: Gender.values.map((g) => DropdownMenuItem(value: g, child: Text(g.name.toUpperCase()))).toList(),
                              onChanged: (val) => setState(() => _selectedGender = val),
                              validator: AppValidators.validateGender,
                            ),
                            _fieldLabel("Password"),
                            TextFormField(
                              controller: _passController,
                              obscureText: _isObscured,
                              decoration: _inputDecoration("••••••••").copyWith(suffixIcon: IconButton(icon: Icon(_isObscured ? Icons.visibility : Icons.visibility_off, size: 20, color: Colors.grey), onPressed: () => setState(() => _isObscured = !_isObscured))),
                              validator: AppValidators.validatePassword,
                            ),
                            const SizedBox(height: 15),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(12), border: const Border(left: BorderSide(color: Color(0xFF9E2A2B), width: 3))),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                const Text("SECURITY REQUIREMENTS", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                                const SizedBox(height: 8),
                                _buildRequirement("At least 6 characters", hasSixChars),
                                _buildRequirement("One uppercase letter", hasUppercase),
                                _buildRequirement("One special character (!@#\$)", hasSpecialChar),
                              ]),
                            ),
                            _fieldLabel("Confirm Password"),
                            _buildTextField(_confirmPassController, "••••••••", (val) => AppValidators.validateConfirmPassword(val, _passController.text), isPass: true),
                            const SizedBox(height: 30),
                            SizedBox(width: double.infinity, height: 55, child: ElevatedButton(onPressed: _handleRegistration, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0047AB), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))), child: const Text("Register Account", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)))),
                            const SizedBox(height: 20),
                            Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Text("Already have an account? "), GestureDetector(onTap: () => Navigator.pop(context), child: const Text("Log in here", style: TextStyle(color: Color(0xFF0047AB), fontWeight: FontWeight.bold)))]))
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Center(child: Text("BY REGISTERING, YOU AGREE TO THE\nLEDGER'S TERMS OF SERVICE AND PRIVACY POLICY.", textAlign: TextAlign.center, style: TextStyle(fontSize: 9, color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 1.1))),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) => InputDecoration(hintText: hint, fillColor: const Color(0xFFF1F4FF), filled: true, border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none), contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16));
  Widget _buildTextField(TextEditingController ctrl, String hint, String? Function(String?)? validator, {bool isPass = false}) => TextFormField(controller: ctrl, obscureText: isPass, decoration: _inputDecoration(hint), validator: validator);
}
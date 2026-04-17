import 'enums.dart';

class AppValidators {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'Full name is required';
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email address';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Minimum 6 characters required';
    if (!value.contains(RegExp(r'[A-Z]'))) return 'At least one uppercase letter required';
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<> ]'))) return 'At least one special character required';
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value != password) return 'Passwords do not match';
    return null;
  }
  
  static String? validateGender(Gender? value) {
    if (value == null) return 'Please select your gender';
    return null;
  }
}
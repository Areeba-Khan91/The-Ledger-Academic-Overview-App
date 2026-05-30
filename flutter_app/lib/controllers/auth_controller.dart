class UserData {
  final String name;
  final String email;
  final String password;
  UserData({required this.name, required this.email, required this.password});
}

class AuthController {
  // Static list to act as a temporary database
  static final List<UserData> _registeredUsers = [];
  
  // To track who is currently logged in
  static UserData? loggedInUser;

  static void registerUser(String name, String email, String password) {
    _registeredUsers.add(UserData(name: name, email: email, password: password));
  }

  static bool loginUser(String email, String password) {
    for (var user in _registeredUsers) {
      if (user.email == email && user.password == password) {
        loggedInUser = user;
        return true;
      }
    }
    return false;
  }
}
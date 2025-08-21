class ApiService {
  /// 🔥 User Sign Up
  Future<Map<String, dynamic>> signup(
      String name,
      String phone,
      String email,
      String password,
      String referralCode,
      ) async {
    // Simulate a successful registration
    await Future.delayed(const Duration(milliseconds: 500));
    return {
      'success': true,
      'message': 'Registration successful!',
      'uid': 'mock-uid-123',
    };
  }

  /// 🔑 User Login
  Future<Map<String, dynamic>> login(String email, String password) async {
    // Simulate a successful login with hardcoded credentials
    await Future.delayed(const Duration(milliseconds: 500));
    if (email == 'test@example.com' && password == 'password123') {
      return {
        'success': true,
        'message': 'Login successful!',
        'uid': 'mock-uid-123',
        'role': 'user',
      };
    } else {
      return {'success': false, 'message': 'Invalid credentials.'};
    }
  }

  /// 👥 Get Referred Users
  Future<List<Map<String, dynamic>>> getReferredUsers(
      String distributorPhone,
      ) async {
    // Return dummy data
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      {
        'name': 'Referred User 1',
        'phone': '9876543210',
        'email': 'referred1@example.com',
      },
      {
        'name': 'Referred User 2',
        'phone': '9876543211',
        'email': 'referred2@example.com',
      },
    ];
  }

  /// 📊 Get All Users
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    // Return dummy data
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      {
        'name': 'User A',
        'email': 'userA@example.com',
        'role': 'user',
      },
      {
        'name': 'User B',
        'email': 'userB@example.com',
        'role': 'distributor',
      },
    ];
  }
}
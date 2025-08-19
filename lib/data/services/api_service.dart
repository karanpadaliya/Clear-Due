class ApiService {
  Future<Map<String, dynamic>> signup(String name, String phone, String email, String password) async {
    // API call को simulate करने के लिए 2 सेकंड का delay
    await Future.delayed(const Duration(seconds: 2));
    if (name.isNotEmpty && phone.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      // Backend से आने वाले mock response को simulate करें
      return {
        'success': true,
        'message': 'Registration successful!',
        'data': {
          'uid': 'uid-mock-${DateTime.now().millisecondsSinceEpoch}',
          'name': name,
          'phone': phone,
          'email': email,
          'token': 'fcm_device_token_mock',
          'kycStatus': 'pending',
          'bookmarks': [],
          'createdAt': DateTime.now().toIso8601String(),
          'updatedAt': DateTime.now().toIso8601String(),
          'isActive': true,
          'role': 'customer',
        }
      };
    } else {
      return {'success': false, 'message': 'All fields are required.'};
    }
  }

  Future<Map<String, dynamic>> login(String phone, String password) async {
    // API call को simulate करने के लिए 2 सेकंड का delay
    await Future.delayed(const Duration(seconds: 2));
    if (phone == '+919876543210' && password == 'password123') {
      return {'success': true, 'message': 'Login successful!', 'uid': 'abc-123'};
    } else {
      return {'success': false, 'message': 'Invalid credentials.'};
    }
  }
}

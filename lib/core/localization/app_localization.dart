import 'package:get/get.dart';

class AppLocalization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      'title': "Create a New Account",
      'subtitle': "Join us to manage your bills easily",
      'fullName': "Full Name",
      'mobile': "Mobile Number",
      'email': "Email Address",
      'password': "Password",
      'signUp': "Sign Up",
      'haveAccount': "Already have an account? Login",
    },
    'hi': {
      'title': "नया खाता बनाएं",
      'subtitle': "हमारे साथ जुड़ें और बिल आसानी से मैनेज करें",
      'fullName': "पूरा नाम",
      'mobile': "मोबाइल नंबर",
      'email': "ईमेल पता",
      'password': "पासवर्ड",
      'signUp': "साइन अप",
      'haveAccount': "पहले से खाता है? लॉगिन करें",
    }
  };
}

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
      'noAccount': "Don't have an account? Sign up",
      'errorRequired': "This field is required",
      'errorInvalidEmail': "Please enter a valid email",
      'errorInvalidPhone': "Please enter a valid phone number",
      'loading': "Loading...",
      'submit': "Submit",
      'login': "Login",
      'logout': "Logout",
      // Add any other needed keys here
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
      'errorRequired': "यह फ़ील्ड आवश्यक है",
      'errorInvalidEmail': "कृपया एक मान्य ईमेल दर्ज करें",
      'errorInvalidPhone': "कृपया एक मान्य फोन नंबर दर्ज करें",
      'loading': "लोड हो रहा है...",
      'submit': "जमा करें",
      'login': "लॉगिन",
      'logout': "लॉगआउट",
      // Add any other needed keys here in Hindi
    }
  };
}

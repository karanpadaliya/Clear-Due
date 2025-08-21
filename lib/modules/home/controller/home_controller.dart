import 'package:get/get.dart';

class HomeController extends GetxController {
  var username = "User".obs;

  // ✅ Bottom navigation handling
  var selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
    // yaha navigation ya page switch karna ho to kar sakte ho
  }
}

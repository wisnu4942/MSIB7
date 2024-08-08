import 'package:get/get.dart';

class PalindromeController extends GetxController {
  var inputText = ''.obs;

  bool isPalindrome(String text) {
    String sanitized = text.replaceAll(RegExp(r'\s+'), '').toLowerCase();
    return sanitized == sanitized.split('').reversed.join('');
  }
}

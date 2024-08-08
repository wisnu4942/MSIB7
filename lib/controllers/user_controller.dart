import 'package:get/get.dart';

class FirstScreenController extends GetxController {
  var enteredName = ''.obs;
  void setEnteredName(String name) {
    enteredName.value = name;
  }
}

class ThirdScreenController extends GetxController {
  var selectedUserName = ''.obs;
  void setSelectedUserName(String name) {
    selectedUserName.value = name;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/user_controller.dart';

class SecondScreen extends StatelessWidget {
  final FirstScreenController firstScreenController =
      Get.put(FirstScreenController());
  final ThirdScreenController thirdScreenController =
      Get.put(ThirdScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Second Screen',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.indigo[600],
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 1.0,
            color: Colors.grey[300],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(fontSize: 15),
                  ),
                  Obx(() => Text(
                        firstScreenController.enteredName.value,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(height: 210),
                  Center(
                    child: Obx(() => Text(
                          thirdScreenController.selectedUserName.value.isEmpty
                              ? 'No Selected User Name'
                              : thirdScreenController.selectedUserName.value,
                          style: TextStyle(
                              fontSize: 29, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () => Get.toNamed('/third'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(1, 43, 99, 123).withOpacity(0.8),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Choose a User',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

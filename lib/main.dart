import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/first_screen.dart';
import 'views/second_screen.dart';
import 'views/third_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Suitmedia Intern Project',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => FirstScreen()),
        GetPage(name: '/second', page: () => SecondScreen()),
        GetPage(name: '/third', page: () => ThirdScreen()),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tele_tudo_app/HomePage.dart';
import 'LoginPage.dart';
import 'features/life_cycle_state.dart';

void main() {
  runApp(LifeCycleState(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    ),
  ));
}

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: LoginPage(),
//   ));
// }

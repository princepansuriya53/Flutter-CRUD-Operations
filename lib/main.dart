import 'package:flutter/material.dart';
import 'package:i_u_d/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EmployeeListScreen(),
    );
  }
}

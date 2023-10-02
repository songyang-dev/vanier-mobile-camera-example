import 'package:flutter/material.dart';

import 'home/home.dart';

void main() {
  runApp(const CameraApp());
}

class CameraApp extends StatelessWidget {
  const CameraApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Camera Demo',
      home: HomeScreen(),
    );
  }
}

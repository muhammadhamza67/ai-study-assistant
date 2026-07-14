import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const StudyAssistantApp());
}

class StudyAssistantApp extends StatelessWidget {
  const StudyAssistantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Study Assistant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}
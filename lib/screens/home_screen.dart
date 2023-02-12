import 'package:flutter/material.dart';
import 'package:note_app/style/app_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        elevation: 0.0,
        title: Text('FireNotes'),
        centerTitle: true,
        backgroundColor: AppStyle.mainColor,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CodeforcesPage extends StatefulWidget {
  const CodeforcesPage({super.key});

  @override
  State<CodeforcesPage> createState() => _CodeforcesPageState();
}

class _CodeforcesPageState extends State<CodeforcesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CodeForrcs"),
      ),
      body: Center(child: Text("welcome")),
    );
  }
}

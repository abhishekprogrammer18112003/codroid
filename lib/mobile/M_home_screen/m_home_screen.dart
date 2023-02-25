import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../m_courses_screen/m_courses_screen.dart';
import '../m_forums_screen/m_forum_screen.dart';
import '../m_ide_screen/m_ide_screen.dart';
import '../m_main_screen/m_main_screen.dart';
import '../m_practice_screen/m_practicescreen.dart';

class MobileHomeScreen extends StatefulWidget {
  final int initialIndex;
  const MobileHomeScreen({super.key, this.initialIndex = 0});

  @override
  State<MobileHomeScreen> createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
  late PageController _pageController;
  final List<Widget> _screens = const [
    MobileHomeScreen(),
    MobileCoursesScreen(),
    MobilePracticeScreen(),
    MobileForumsScreen(),
    MobileIdeScreen()
  ];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Codroid'),
      ),
      body: text("home screen")
    );
  }
}

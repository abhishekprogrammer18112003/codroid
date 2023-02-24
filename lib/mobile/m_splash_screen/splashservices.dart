import 'dart:async';

import 'package:codroid/mobile/m_onboarding_screen/m_onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../M_home_screen/m_home_screen.dart';
import '../login_signup_welcome/Screens/Welcome/welcome_screen.dart';

class splashservices {
  void islogin(BuildContext context) async {
    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    if (user != null) {
      Timer(
          const Duration(seconds: 5),
          () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MobileHomeScreen())));
    } else {
      Timer(
          const Duration(seconds: 5),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => MobileOnboardingPage())));
    }
  }
}

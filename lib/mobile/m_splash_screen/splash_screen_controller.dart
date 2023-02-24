import 'package:codroid/mobile/M_home_screen/m_home_screen.dart';
import 'package:codroid/mobile/login_signup_welcome/Screens/Login/login_screen.dart';
import 'package:codroid/mobile/login_signup_welcome/Screens/Welcome/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../m_onboarding_screen/m_onboarding_screen.dart';

class SplashScreenController extends GetxController {
  static SplashScreenController get find => Get.find();

  RxBool animate = false.obs;

  Future startAnimation() async {
    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true;
    await Future.delayed(const Duration(milliseconds: 5000));
    if (user != null) {
      Get.to(() => MobileHomeScreen());
    } else {
      Get.to(() => MobileWelcomeScreen());
    }
  }
}

import 'package:codroid/mobile/m_onboarding_screen/m_onboarding_screen.dart';
import 'package:codroid/utils/responsive.dart';
import 'package:codroid/utils/themes/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'desktop/d_splash_screen/d_splash_screen.dart';
import 'mobile/m_splash_screen/m_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themes.lighttheme,
      darkTheme: themes.darktheme,
      themeMode: ThemeMode.light,
      home: Responsive(
        mobile: MobileSplashScreen(),
        desktop: DesktopSplashScreen(),
      ),
    );
  }
}

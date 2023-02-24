import 'dart:async';

import 'package:codroid/constants/colors.dart';
import 'package:codroid/constants/images.dart';
import 'package:codroid/constants/lottieconstant.dart';
import 'package:codroid/constants/sizes.dart';
import 'package:codroid/constants/text.dart';
import 'package:codroid/main.dart';
import 'package:codroid/mobile/m_splash_screen/splash_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lottie/lottie.dart';

import 'splashservices.dart';

class MobileSplashScreen extends StatefulWidget {
  MobileSplashScreen({Key? key}) : super(key: key);

  @override
  State<MobileSplashScreen> createState() => _MobileSplashScreenState();
}

class _MobileSplashScreenState extends State<MobileSplashScreen> {
  // final splashController = Get.put(SplashScreenController());
  splashservices splash = splashservices();
  bool animate = true;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 500), () => animate = true);

    splash.islogin(context);
  }

  @override
  Widget build(BuildContext context) {
    // SplashScreenController.find.startAnimation();

    return Scaffold(
      // backgroundColor: tprimarycolor,
      body: Stack(
        children: [
          // Obx(
          //   () => AnimatedPositioned(
          //     duration: const Duration(milliseconds: 1600),
          //     top: splashController.animate.value ? 0 : -30,
          //     left: splashController.animate.value ? 0 : -30,
          //     child: AnimatedOpacity(
          //       duration: const Duration(milliseconds: 1600),
          //       opacity: splashController.animate.value ? 1 : 0,
          //       child: const Image(image: AssetImage(tSplashTopIcon)),
          //     ),
          //   ),
          // ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 2400),
            top: animate ? 0 : -30,
            left: animate ? 0 : -30,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 2000),
              opacity: animate ? 1 : 0,
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(100)),
                  color: tsecondarycolor,
                ),
              ),
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 2000),
            top: 130,
            left: animate ? tdefaultsize : -80,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 2000),
              opacity: animate ? 1 : 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(tappname,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text(tapptagline, style: TextStyle(fontSize: 25))
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 2400),
                  bottom: animate ? 160 : -20,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 2000),
                    opacity: animate ? 1 : 0,
                    child: Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.52,
                        width: MediaQuery.of(context).size.width * 1.1,
                        // color: Colors.black,
                        child: Image(
                          image: AssetImage(tsplashimage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 2400),
                  bottom: animate ? 160 : -20,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 2000),
                    opacity: animate ? 1 : 0,
                    child: Center(
                      child: AnimatedPositioned(
                        duration: const Duration(milliseconds: 2400),
                        bottom: animate ? 160 : -20,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 2000),
                          opacity: animate ? 1 : 0,
                          child: Center(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width * 0.8,
                              // color: Colors.black,
                              child: Lottie.asset(lottie.loadinglottie),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 2400),
            bottom: animate ? 30 : 0,
            right: tdefaultsize,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 2000),
              opacity: animate ? 1 : 0,
              child: Container(
                width: tsplashcontainersize + 20,
                height: tsplashcontainersize + 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: tsecondarycolor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

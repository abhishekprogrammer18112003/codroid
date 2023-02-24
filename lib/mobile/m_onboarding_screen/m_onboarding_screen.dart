import 'package:codroid/constants/images.dart';
import 'package:flutter/material.dart';

import '../login_signup_welcome/Screens/Welcome/welcome_screen.dart';

class MobileOnboardingPage extends StatefulWidget {
  @override
  _MobileOnboardingPageState createState() => _MobileOnboardingPageState();
}

class _MobileOnboardingPageState extends State<MobileOnboardingPage> {
  int currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  List<Map<String, String>> onboardingData = [
    {
      "title": "Welcome to My App!",
      "text": "This app helps you do amazing things. Get started now!",
      "image": tsplashimage
    },
    {
      "title": "Explore Your Interests",
      "text":
          "Find things you love and connect with others who share your interests.",
      "image": tsplashimage
    },
    {
      "title": "Connect with Friends",
      "text":
          "Stay connected with your friends and family no matter where you are.",
      "image": tsplashimage
    },
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: onboardingData.length,
                itemBuilder: (context, index) => OnboardingCard(
                  title: onboardingData[index]["title"]!,
                  text: onboardingData[index]["text"]!,
                  image: onboardingData[index]["image"]!,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Visibility(
                  visible: currentPage != 0,
                  child: ElevatedButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    child: Text("Previous"),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (currentPage == onboardingData.length - 1) {
                      // Go to home page
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MobileWelcomeScreen()));
                    } else {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    }
                  },
                  child: Text(currentPage == onboardingData.length - 1
                      ? "Finish"
                      : "Next"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingCard extends StatelessWidget {
  final String title;
  final String text;
  final String image;

  OnboardingCard({
    required this.title,
    required this.text,
    required this.image,
  });

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 48.0),
        Image.asset(
          image,
          height: MediaQuery.of(context).size.height * 0.5,
        ),
        SizedBox(height: 48.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        SizedBox(height: 32.0),
      ],
    );
  }
}

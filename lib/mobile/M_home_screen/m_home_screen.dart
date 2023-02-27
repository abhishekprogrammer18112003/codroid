import 'dart:io';

import 'package:codroid/constants/colors.dart';
import 'package:codroid/mobile/login_signup_welcome/Screens/Signup/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../m_courses_screen/m_courses_screen.dart';
import '../m_forums_screen/m_forum_screen.dart';
import '../m_ide_screen/m_ide_screen.dart';
import '../m_main_screen/m_main_screen.dart';
import '../m_practice_screen/m_practicescreen.dart';

class MobileHomeScreen extends StatefulWidget {
  const MobileHomeScreen({Key? key}) : super(key: key);

  @override
  _MobileHomeScreenState createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
  File? imgfile;
  String? _imagepath;
  var user = FirebaseAuth.instance.currentUser;
  String name = 'User';

  @override
  Future getimage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      // final imagepermanent = File(image.path);
      // setState(() {
      //   this._image = imagepermanent;
      // });
      setState(() {
        saveimage(image.path.toString());
        imgfile = File(image.path);
      });
    } on PlatformException catch (e) {
      print("failed to pick image : $e");
    }
  }

  void saveimage(path) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("profileimage", path);
    loadprofileimage();
  }

  @override
  void initState() {
    super.initState();
    loadprofileimage();
    // name = user!.displayName == '' ? 'User' : user!.displayName!;
  }

  void loadprofileimage() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      _imagepath = sp.getString("profileimage");
    });
    // sp.setString("profileimage", path);
  }

  int _currentIndex = 0;

  final List<Widget> _pages = [
    MobileMainScreen(),
    MobileCoursesScreen(),
    LeetCodeScreen(),
    MobileForumsScreen(),
    MobileIdeScreen()
  ];
  
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    Future<bool> showExitPopup() async {
      return await showDialog( //show confirm dialogue 
        //the return value will be from "Yes" or "No" options
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          title: Text('Exit App'),
          content: Text('Do you want to exit the App?'),
          actions:[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
               //return false when click on "NO"
              child:Text('No'),
            ),

            ElevatedButton(
              onPressed: () => Navigator.of(context).popUntil(ModalRoute.withName('/')), 
              //return true when click on "Yes"
              child:Text('Yes'),
            ),

          ],
        ),
      )??false; //if showDialouge had returned null, then return false
    }

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text("CODROID", style: TextStyle(letterSpacing: 2.0),),
          automaticallyImplyLeading: false,
          leading: IconButton(onPressed: (){
          _scaffoldKey.currentState?.openDrawer();}, icon: const Icon(Icons.menu)),
        ),
    
        //drawer
        drawer: Drawer(
            child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: GestureDetector(
                        onTap: () {
                          getimage();
                          saveimage(imgfile!.path);
                        },
                        child: _imagepath != null
                            ? CircleAvatar(
                                radius: 50,
                                backgroundImage: FileImage(File(_imagepath!)),
                              )
                            : const CircleAvatar(
                                radius: 40,
                                child: Icon(Icons.add),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Text(
                      "Hello, $name",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    Text(
                      "${user?.email}",
                      style: TextStyle(
                          fontSize: 13,
                          // fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ],
                ),
              ),
            ),
            //DrawerHeader
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Courses'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.sync_problem),
              title: const Text('Practice Problems'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.chat),
              title: const Text('Discussion'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_label),
              title: const Text('Video Courses'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.pages),
              title: const Text('SDE Sheets'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Account'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        )),
        //body
    
        body: _pages[_currentIndex],
    
        //bottom navigation bar
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: Colors.blue,
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          ),
          child: BottomNavigationBar(
            selectedItemColor: Color.fromARGB(255, 248, 246, 248),
            unselectedItemColor: Color.fromARGB(255, 0, 0, 0),
            currentIndex: _currentIndex,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: 'Courses',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sync_problem),
                label: 'Problems',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.forum),
                label: 'Forums',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            elevation: 30,
          ),
        ),
      ),
    );
  }
}

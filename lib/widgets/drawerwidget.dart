import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidegt extends StatefulWidget {
      DrawerWidegt({super.key});

  @override
  State<DrawerWidegt> createState() => _DrawerWidegtState();
}

class _DrawerWidegtState extends State<DrawerWidegt> {
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
        ));
  }
}

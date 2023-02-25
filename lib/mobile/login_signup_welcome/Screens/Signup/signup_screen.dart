// import 'package:flutter/material.dart';
// import 'package:flutter_auth/constants.dart';
// import 'package:flutter_auth/responsive.dart';
// import '../../components/background.dart';
// import 'components/sign_up_top_image.dart';
// import 'components/signup_form.dart';
// import 'components/socal_sign_up.dart';

// class SignUpScreen extends StatelessWidget {
//   const SignUpScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Background(
//       child: SingleChildScrollView(
//         child: Responsive(
//           mobile: const MobileSignupScreen(),
//           desktop: Row(
//             children: [
//               const Expanded(
//                 child: SignUpScreenTopImage(),
//               ),
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: const [
//                     SizedBox(
//                       width: 450,
//                       child: SignUpForm(),
//                     ),
//                     SizedBox(height: defaultPadding / 2),
//                     // SocalSignUp()
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MobileSignupScreen extends StatelessWidget {
//   const MobileSignupScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         const SignUpScreenTopImage(),
//         Row(
//           children: const [
//             Spacer(),
//             Expanded(
//               flex: 8,
//               child: SignUpForm(),
//             ),
//             Spacer(),
//           ],
//         ),
//         // const SocalSignUp()
//       ],
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../M_home_screen/m_home_screen.dart';
import '../../constants.dart';

import '../../services/sharedpref.dart';
import '../../services/toastservice.dart';
import '../Login/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  File? _image;
  late String _imagepath;

  @override
  Future getimage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imagepermanent = File(image.path);
      setState(() {
        saveimage(image.path.toString());
        this._image = imagepermanent;
      });
    } on PlatformException catch (e) {
      print("failed to pick image : $e");
    }
  }

  void saveimage(path) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("profileimage", path);
  }

  // Future<File> savefilepermanently(String imagepath) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final name = basename(imagepath);
  //   final image = File("${directory.path}/$name");

  //   return File(imagepath).copy(image.path);
  // }

  // void getimage() async {
  //   var image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     this._image = image as File;
  //   });
  // }
  bool loading = false;
  sharedpref sp = sharedpref();
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _phonenocontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    _namecontroller.dispose();
    _phonenocontroller.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  void signup(BuildContext context) {
    sp.setemail(_emailcontroller.text.toString());
    sp.setname(_namecontroller.text.toString());
    sp.setphone(_phonenocontroller.text.toString());
    setState(() {
      loading = true;
    });
    // sp.setlogin(true);
    _auth
        .createUserWithEmailAndPassword(
            email: _emailcontroller.text.toString(),
            password: _passwordcontroller.text.toString())
        .then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MobileHomeScreen()));
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      fluttertoast().toast(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                const Text(
                  "Create Your Profile",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                GestureDetector(
                  onTap: () {
                    getimage();
                    saveimage(_image!.path);
                  },
                  // ignore: unnecessary_null_comparison
                  child: (_image != null)
                      ? CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(_image!),
                        )
                      : CircleAvatar(
                          radius: 50,
                          child: Icon(
                            Icons.add,
                            size: 40,
                          ),
                        ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text("Select profile picture"),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Form(
                    key: _formkey,
                    child: Column(children: [
                      TextFormField(
                        controller: _namecontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Your Name";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.name,
                        //textInputAction: TextInputAction.next,
                        cursorColor: kPrimaryColor,

                        decoration: const InputDecoration(
                          hintText: "Your Name",
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(defaultPadding),
                            child: Icon(Icons.person),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _phonenocontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Phone Number";
                          } else {
                            return null;
                          }
                        },
                        //textInputAction: TextInputAction.done,
                        //obscureText: true,
                        cursorColor: kPrimaryColor,
                        decoration: const InputDecoration(
                          hintText: "Your phone number",
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(defaultPadding),
                            child: Icon(Icons.phone),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailcontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Email Address";
                          } else {
                            return null;
                          }
                        },
                        //textInputAction: TextInputAction.done,
                        //obscureText: true,
                        cursorColor: kPrimaryColor,
                        decoration: const InputDecoration(
                          hintText: "Your Email Address",
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(defaultPadding),
                            child: Icon(Icons.email),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _passwordcontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Password";
                          } else {
                            return null;
                          }
                        },
                        //textInputAction: TextInputAction.done,
                        obscureText: true,
                        cursorColor: kPrimaryColor,
                        decoration: const InputDecoration(
                          hintText: "Your Password",
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(defaultPadding),
                            child: Icon(Icons.lock),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                const SizedBox(height: defaultPadding),
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Hero(
                    tag: "login_btn",
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          signup(context);
                        }
                      },
                      child: loading == true
                          ? CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Colors.white,
                            )
                          : Text(
                              "Create Account".toUpperCase(),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Have an Account ?",
                      style: TextStyle(color: Color(0xFF6F35A5)),
                    ),
                    TextButton(
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: Color(0xFF6F35A5),
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

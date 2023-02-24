// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../M_home_screen/m_home_screen.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../../services/sharedpref.dart';
import '../../../services/toastservice.dart';
import '../../Signup/signup_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool loading = false;
  sharedpref sp = sharedpref();
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  void login() {
    setState(() {
      loading = true;
    });
    sp.setemail(_emailcontroller.text.toString());
    // sp.setlogin(true);
    _auth
        .signInWithEmailAndPassword(
            email: _emailcontroller.text.toString(),
            password: _passwordcontroller.text.toString())
        .then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MobileHomeScreen()));
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      debugPrint(error.toString());
      fluttertoast().toast(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(children: [
        TextFormField(
          controller: _emailcontroller,
          validator: (value) {
            if (value!.isEmpty) {
              return "Enter email";
            } else {
              return null;
            }
          },
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          cursorColor: kPrimaryColor,
          onSaved: (email) {},
          decoration: const InputDecoration(
            hintText: "Your email",
            prefixIcon: Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Icon(Icons.person),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: TextFormField(
            controller: _passwordcontroller,
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter Password";
              } else {
                return null;
              }
            },
            textInputAction: TextInputAction.done,
            obscureText: true,
            cursorColor: kPrimaryColor,
            decoration: const InputDecoration(
              hintText: "Your password",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.lock),
              ),
            ),
          ),
        ),
        const SizedBox(height: defaultPadding),
        Hero(
          tag: "login_btn",
          child: ElevatedButton(
            onPressed: () async {
              if (_formkey.currentState!.validate()) {
                login();
              }
            },
            child: loading == true
                ? CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.white,
                  )
                : Text(
                    "Login".toUpperCase(),
                  ),
          ),
        ),
        const SizedBox(height: defaultPadding),
        AlreadyHaveAnAccountCheck(
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return SignUpScreen();
                },
              ),
            );
          },
        ),
      ]),
    );
  }
}

// ignore_for_file: camel_case_types

import 'package:shared_preferences/shared_preferences.dart';

class sharedpref {
  // bool islogin = false;
  // late String name;
  // late String email;
  // late String phone;
  void setemail(String emailcontroller) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("email", emailcontroller);
  }

  void setname(String namecontroller) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("name", namecontroller);
  }

  void setphone(String phonecontroller) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("email", phonecontroller);
  }

  void setlogin(bool login) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool("islogin", login);
  }
}

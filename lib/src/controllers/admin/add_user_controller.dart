import 'package:disneyland_character_votin_app/src/models/user.dart';
import 'package:disneyland_character_votin_app/src/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddUserController extends GetxController {
  int? id;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool obsecure = false;
  IconData suffixPassword = Icons.visibility_off;

  toggleObsecure() {
    // print(obsecure);
    if (obsecure) {
      obsecure = false;
      suffixPassword = Icons.visibility;
    } else {
      obsecure = true;
      suffixPassword = Icons.visibility_off;
    }
    update();
  }

  addUser() async {
    User user =
        User(username: username.text.trim(), password: password.text.trim());

    await DatabaseHelper.instance.insertUser(user.toJson());
  }

  updateUser() async {
    // print(username.text);
    User user =
        User(username: username.text.trim(), password: password.text.trim());

    await DatabaseHelper.instance.updateUser(user.toJson(), id);
  }
}

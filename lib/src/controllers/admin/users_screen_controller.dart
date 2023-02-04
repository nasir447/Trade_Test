import 'package:disneyland_character_votin_app/src/models/user.dart';
import 'package:disneyland_character_votin_app/src/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersScreenController extends GetxController {
  List<User> users = [];
  TextEditingController searchBar = TextEditingController();
  bool search = false;
  List<User> serchedUser = [];

  UsersScreenController() {
    readUsers();
  }

  Future readUsers() async {
    var result = await DatabaseHelper.instance.readUsers();
    // print(result);
    users = [];
    for (var r in result) {
      users.add(User.fromJson(r));
    }
    update();
  }

  searchUsers() {
    serchedUser = [];
    for (var u in users) {
      if (u.username
              .toLowerCase()
              .contains(searchBar.text.trim().toLowerCase()) ||
          u.password
              .toLowerCase()
              .contains(searchBar.text.trim().toLowerCase())) {
        serchedUser.add(u);
      }
    }
    if (searchBar.text.trim().isEmpty) {
      search = false;
    } else {
      search = true;
    }
    update();
  }
}

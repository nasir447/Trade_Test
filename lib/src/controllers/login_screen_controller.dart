import 'package:disneyland_character_votin_app/src/models/character.dart';
import 'package:disneyland_character_votin_app/src/models/user.dart';
import 'package:disneyland_character_votin_app/src/services/database_helper.dart';
import 'package:disneyland_character_votin_app/src/views/admin/bottom_nav_bar.dart';
import 'package:disneyland_character_votin_app/src/views/user/voting_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool obsecure = true;
  IconData suffixPassword = Icons.visibility_off;
  String role = 'User';
  User? user;

  toggleObsecure() {
    if (obsecure) {
      obsecure = false;
      suffixPassword = Icons.visibility;
    } else {
      obsecure = true;
      suffixPassword = Icons.visibility_off;
    }
    update();
  }

  setRole(r) {
    role = r;
    update();
  }

  loginAdmin() async {
    String inputEmail = email.text.trim();
    String inputPassword = password.text.trim();

    final prefs = await SharedPreferences.getInstance();

    final bool firstTime = prefs.getBool('first_time') ?? true;
    final String emailSet = prefs.getString('email') ?? "admin";
    final String passwordSet = prefs.getString('password') ?? "123";
    await prefs.setBool('first_time', false);
    await prefs.setString('email', emailSet);
    await prefs.setString('password', passwordSet);

    // print(firstTime);

    if (role == 'Admin' &&
        inputEmail == emailSet &&
        inputPassword == passwordSet) {
      if (firstTime) {
        List<Character> characters = [
          Character(
              characterName: 'Mickey Mouse',
              charactePicture:
                  'https://guardian.ng/wp-content/uploads/2022/07/mickey-mouse.jpeg'),
          Character(
              characterName: 'Goofy',
              charactePicture:
                  'https://static.wikia.nocookie.net/disney/images/2/27/Goofy_transparent.png/revision/latest?cb=20200308081711'),
          Character(
              characterName: 'Tiger',
              charactePicture:
                  'https://static.wikia.nocookie.net/p__/images/a/a9/PI_Tigger.png/revision/latest?cb=20220820122131&path-prefix=protagonist'),
          Character(
              characterName: 'Minnie Mouse',
              charactePicture:
                  'https://static.wikia.nocookie.net/disney/images/1/14/MinnieMouse.png/revision/latest?cb=20140306174453&path-prefix=es'),
          Character(
              characterName: 'Jack Skellington',
              charactePicture:
                  'https://m.media-amazon.com/images/I/81yH2CpDTzL._AC_SX679_.jpg'),
          Character(
              characterName: 'Winnie-the-Pooh',
              charactePicture:
                  'https://static.wikia.nocookie.net/p__/images/6/6e/Winnie_The_Pooh.png/revision/latest/scale-to-width-down/289?cb=20190922201041&path-prefix=protagonist'),
          Character(
              characterName: 'Daisy Duck',
              charactePicture:
                  'https://static.wikia.nocookie.net/great-characters/images/5/5e/Daisy-duck6.png/revision/latest/scale-to-width-down/290?cb=20210427093727'),
          Character(
              characterName: 'Tiana',
              charactePicture:
                  'https://static.wikia.nocookie.net/disneyprincess/images/5/56/Tiana.13.png/revision/latest/scale-to-width-down/350?cb=20180601173852'),
          Character(
              characterName: 'Ariel',
              charactePicture:
                  'https://static.wikia.nocookie.net/disneyprincess/images/3/38/Disney_Princess_Ariel_2015.png/revision/latest/scale-to-width-down/350?cb=20180521030057'),
          Character(
              characterName: 'Buzz Lightyear',
              charactePicture:
                  'https://m.media-amazon.com/images/I/61dTYKO7dKL._AC_SY879_.jpg'),
          Character(
              characterName: 'Eeyore',
              charactePicture:
                  'https://static.wikia.nocookie.net/disney/images/1/1c/Profile_-_Eeyore.png/revision/latest/scale-to-width-down/516?cb=20210516060155'),
          Character(
              characterName: 'Pluto',
              charactePicture:
                  'https://qph.cf2.quoracdn.net/main-qimg-0e1eba699aac9ad05b6f8abe98b8bdbb-lq'),
          Character(
              characterName: 'Tinker Bell',
              charactePicture:
                  'https://static.wikia.nocookie.net/disney/images/7/76/Profile_-_Tinker_Bell.jpeg/revision/latest?cb=20190312151821'),
          Character(
              characterName: 'Rapunzel',
              charactePicture:
                  'https://static.wikia.nocookie.net/disneyprincess/images/0/0e/Disney_Princess_Rapunzel_2016.png/revision/latest?cb=20190524201937'),
          Character(
              characterName: 'Snow White',
              charactePicture:
                  'https://m.media-amazon.com/images/I/516TmpEF-IL._SX362_BO1,204,203,200_.jpg'),
        ];
        for (var character in characters) {
          await DatabaseHelper.instance.insertCharacter(character.toJson());
        }
      }
      email.clear();
      password.clear();
      role = "User";
      update();
      Get.off(BottomNav());
    } else {
      Fluttertoast.showToast(
          msg: 'Username or Password incorrect',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  loginUser() async {
    String inputEmail = email.text.trim();
    String inputPassword = password.text.trim();

    // print('$inputEmail $inputPassword');

    List<User> users = [];

    var result = await DatabaseHelper.instance.readUsers();
    // print(result);
    users = [];
    for (var r in result) {
      users.add(User.fromJson(r));
    }

    bool emailFlag = false, passFlag = false;

    for (var u in users) {
      if (u.username == inputEmail) {
        if (u.password == inputPassword) {
          emailFlag = true;
          passFlag = true;
          user = u;
          break;
        }
      }
    }

    // print('$emailFlag $passFlag');

    if (role == 'User' && emailFlag && passFlag) {
      email.clear();
      password.clear();
      role = "User";
      update();
      Get.off(VotingScreen());
    } else {
      Fluttertoast.showToast(
          msg: 'Username or Password incorrect',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}

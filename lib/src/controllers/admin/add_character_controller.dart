import 'package:disneyland_character_votin_app/src/models/character.dart';
import 'package:disneyland_character_votin_app/src/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCharacterController extends GetxController {
  int? id;
  TextEditingController characterName = TextEditingController();
  TextEditingController characterPicture = TextEditingController();

  addCharacter() async {
    Character character = Character(
        characterName: characterName.text.trim(),
        charactePicture: characterPicture.text.isNotEmpty
            ? characterPicture.text.trim()
            : null);

    await DatabaseHelper.instance.insertCharacter(character.toJson());
  }

  updateCharacter() async {
    // print(username.text);
    Character character = Character(
        characterName: characterName.text.trim(),
        charactePicture: characterPicture.text.isNotEmpty
            ? characterPicture.text.trim()
            : null);

    await DatabaseHelper.instance.updateCharacter(character.toJson(), id);
  }
}

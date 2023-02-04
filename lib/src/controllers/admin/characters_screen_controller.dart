import 'package:disneyland_character_votin_app/src/models/character.dart';
import 'package:disneyland_character_votin_app/src/models/vote.dart';
import 'package:disneyland_character_votin_app/src/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CharactersScreenController extends GetxController {
  List<Character> characters = [];
  TextEditingController searchBar = TextEditingController();
  bool search = false;
  List<Character> serchedCharacter = [];

  CharactersScreenController() {
    readCharacters();
  }

  Future readCharacters() async {
    var result = await DatabaseHelper.instance.readCharacters();
    // print(result);
    characters = [];
    for (var r in result) {
      characters.add(Character.fromJson(r));
    }
    update();
  }

  searchCharacter() {
    serchedCharacter = [];
    for (var c in characters) {
      if (c.characterName
          .toLowerCase()
          .contains(searchBar.text.trim().toLowerCase())) {
        serchedCharacter.add(c);
      }
    }
    if (searchBar.text.trim().isEmpty) {
      search = false;
    } else {
      search = true;
    }
    update();
  }

  voteCast(userId, characterId) async {
    Vote vote = Vote(
      userId: userId,
      characterId: characterId,
    );

    await DatabaseHelper.instance.castVote(vote.toJson());
    Fluttertoast.showToast(
        msg: 'Vote casted successfully. Thankyou.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
    // print(await DatabaseHelper.instance.readVotes());
  }
}

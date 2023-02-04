import 'package:disneyland_character_votin_app/src/models/character.dart';
import 'package:disneyland_character_votin_app/src/models/chart_data.dart';
import 'package:disneyland_character_votin_app/src/models/vote.dart';
import 'package:disneyland_character_votin_app/src/services/database_helper.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnalyticsController extends GetxController {
  List<Vote> votes = [];
  int choice = 0;
  List<ChartData> chartData = [];
  String data = "Grouped Daily";
  String filter = "Select Filter";
  String? startDate, endDate;
  List<Character> characters = [];

  AnalyticsController() {
    readVotes();
    readCharacters();
  }

  setChartType(t, bool top) {
    data = t;
    if (choice == 0) {
      dailyVotes();
    } else if (choice == 1) {
      votesOnCharacter(top);
    } else if (choice == 2) {
      votesOnCharacter(top);
    } else if (choice == 3) {
      timeVotes();
    }
    update();
  }

  setFilter(f) {
    filter = f;
    if (filter == "Select Filter" && data == 'Grouped Daily') {
      readVotes();
    }

    update();
  }

  Future readVotes() async {
    var result = await DatabaseHelper.instance.readVotes();
    // print(result);
    votes = [];
    for (var r in result) {
      votes.add(Vote.fromJson(r));
    }
    dailyVotes();
    // update();
  }

  Future readVotesByDates(String? start, String? end) async {
    var result =
        await DatabaseHelper.instance.readVotesBetweenDates(start, end);
    // print(result);
    votes = [];
    for (var r in result) {
      votes.add(Vote.fromJson(r));
    }
    dailyVotes();

    update();
  }

  dailyVotes() {
    int m = 0, tu = 0, w = 0, th = 0, f = 0, sa = 0, su = 0;
    for (var vote in votes) {
      if (vote.day == 'Monday') {
        m++;
      } else if (vote.day == 'Tuesday') {
        tu++;
      } else if (vote.day == 'Wednesday') {
        w++;
      } else if (vote.day == 'Thursday') {
        th++;
      } else if (vote.day == 'Friday') {
        f++;
      } else if (vote.day == 'Saturday') {
        sa++;
      } else if (vote.day == 'Sunday') {
        su++;
      }
    }

    chartData = [];
    chartData = [
      ChartData(x: "Monday", y: m),
      ChartData(x: "Tuesday", y: tu),
      ChartData(x: "Wednesday", y: w),
      ChartData(x: "Thursday", y: th),
      ChartData(x: "Friday", y: f),
      ChartData(x: "Saturday", y: sa),
      ChartData(x: "Sunday", y: su),
    ];
    // print(chartData);
    update();
  }

  Future readCharacters() async {
    var result = await DatabaseHelper.instance.readCharacters();
    print(result);
    characters = [];
    for (var r in result) {
      characters.add(Character.fromJson(r));
    }
    update();
  }

  votesOnSelectedCharacters(List<int>? characterId) async {
    var result =
        await DatabaseHelper.instance.readVotesOnCharacterId(characterId);
    // print(result);
    votes = [];
    for (var r in result) {
      votes.add(Vote.fromJson(r));
    }
    dailyVotes();

    update();
  }

  votesOnCharacter(bool top) async {
    Map votesOnCharacter = {};

    for (var vote in votes) {
      int numberOfVotes = 0;

      for (var v in votes) {
        if (vote.characterId == v.characterId) {
          numberOfVotes++;
        }
      }
      votesOnCharacter[vote.characterId] = numberOfVotes;
    }

    // print(votesOnCharacter);
    // print(votesOnCharacter.keys);
    List top5Votes = [];
    List top5keys = [];
    if (top) {
      List sortedValues = votesOnCharacter.keys.toList()..sort((a, b) => b - a);
      top5keys = sortedValues.take(5).toList();
      // print(top5keys);
      sortedValues = votesOnCharacter.values.toList()..sort((a, b) => b - a);
      top5Votes = sortedValues.take(5).toList();
      // print(top5Votes);
    }

    Map<String, dynamic> secondMap = {};

    if (top) {
      for (var key in top5keys) {
        int i = top5keys.indexOf(key);
        for (var c in characters) {
          if (key == c.id) {
            secondMap[c.characterName] = top5Votes[i];
            // print('character ${c.characterName}');
          }
        }
      }
    } else {
      for (var key in votesOnCharacter.keys) {
        for (var c in characters) {
          if (key == c.id) {
            secondMap[c.characterName] = votesOnCharacter[key];
          }
        }
      }
    }

    // print(secondMap);

    chartData = [];
    for (var key in secondMap.keys) {
      chartData.add(ChartData(x: key, y: secondMap[key]));
    }

    update();
  }

  timeVotes() {
    // print(votes);
    int m = 0, an = 0, n = 0;
    for (var vote in votes) {
      // print(vote.day);
      if (vote.time == 'Morning') {
        m++;
      } else if (vote.time == 'Afternoon') {
        an++;
      } else if (vote.time == 'Night') {
        n++;
      }
    }

    chartData = [];
    chartData = [
      ChartData(x: "Morning", y: m),
      ChartData(x: "Afternoon", y: an),
      ChartData(x: "Night", y: n),
    ];
    // print(chartData);
    update();
  }
}

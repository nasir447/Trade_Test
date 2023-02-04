import 'package:intl/intl.dart';

class Vote {
  int? id;
  int userId, characterId;
  String? day, date, time;

  Vote({
    this.id,
    required this.userId,
    required this.characterId,
    this.day,
    this.date,
    this.time,
  });

  factory Vote.fromJson(Map<String, dynamic> map) {
    return Vote(
      id: map['vote_id'],
      userId: map['user_id'],
      characterId: map['character_id'],
      day: map['vote_day'],
      date: map['vote_date'],
      time: map['vote_time'],
    );
  }

  Map<String, dynamic> toJson() {
    var date =
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
    var time;
    if (DateTime.now().hour >= 6 && DateTime.now().hour <= 12) {
      time = "Morning";
    } else if (DateTime.now().hour >= 12 && DateTime.now().hour <= 18) {
      time = "Afternoon";
    } else {
      time = "Night";
    }
    // print(time);
    Map<String, dynamic> map = {
      'user_id': userId,
      'character_id': characterId,
      'vote_day': DateFormat('EEEE').format(DateTime.now()).toString(),
      'vote_date': date,
      'vote_time': time,
    };
    return map;
  }
}

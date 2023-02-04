class Character {
  String characterName;
  String? charactePicture;
  int? id;

  Character({
    this.id,
    required this.characterName,
    this.charactePicture,
  });

  factory Character.fromJson(Map<String, dynamic> map) {
    return Character(
        id: map['character_id'],
        characterName: map['character_name'],
        charactePicture: map['character_picture'] ?? "");
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'character_name': characterName,
      'character_picture': charactePicture,
    };
    return map;
  }
}

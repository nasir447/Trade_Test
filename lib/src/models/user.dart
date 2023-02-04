class User {
  String username, password;
  int? id;

  User({
    this.id,
    required this.username,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
        id: map['user_id'],
        username: map['user_name'],
        password: map['user_password']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'user_name': username,
      'user_password': password,
    };
    return map;
  }
}

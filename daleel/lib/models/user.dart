
class User {
  int? user_id;
  String? email;
  String? username;
  String? profilePic;
  // String? passowrd;
  bool? isAdmin;
  bool? isOwner;

  User({this.email, this.user_id, this.isAdmin, this.username, this.isOwner});

  static User fromJson(Map<String, dynamic> json) {
    return User(
    user_id: json['user_id'],
    email: json['email'],
    username: json['username'],
    );
  }

  Map<String, Object> toJson() => {
    'user_id': user_id!,
    'email': email!,
    'username': username!
  };
}
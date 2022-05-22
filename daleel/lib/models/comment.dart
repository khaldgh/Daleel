import 'package:daleel/models/user.dart';

class Comment {
  int? comment_id;
  String? comment;
  User? user;

  Comment({this.comment_id, this.comment, this.user});

  static Comment fromJson(Map<String, dynamic> json) => Comment(
        comment_id: json['comment_id'],
        comment: json['comment'],
        user: User(
          user_id: json['user_id'],
          email: json['email'],
          username: json['username'],
        ),
      );

      void toJson() => {
        'comment_id': comment_id,
        'comment': comment,
      };
}

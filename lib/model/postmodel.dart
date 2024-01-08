import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String UserEmail;
  String Message;
  Timestamp TimeStamp;
  List? Likes;
  String? Path;
  Post({
    required this.UserEmail,
    required this.Message,
    required this.TimeStamp,
    required this.Likes,
    required this.Path,
  });

  Post copyWith({
    String? UserEmail,
    String? Message,
    Timestamp? TimeStamp,
    List? Likes,
    String? Path,
  }) {
    return Post(
      UserEmail: UserEmail ?? this.UserEmail,
      Message: Message ?? this.Message,
      TimeStamp: TimeStamp ?? this.TimeStamp,
      Likes: Likes ?? this.Likes,
      Path: Path ?? this.Path,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'UserEmail': UserEmail,
      'Message': Message,
      'TimeStamp': TimeStamp,
      'Likes': Likes,
      'Path': Path,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      UserEmail: map['UserEmail'] as String,
      Message: map['Message'] as String,
      TimeStamp: map['TimeStamp'],
      Likes: map['Likes'],
      Path: map['Path'] != null ? map['Path'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Post(UserEmail: $UserEmail, Message: $Message, TimeStamp: $TimeStamp, Likes: $Likes, Path: $Path)';
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;

    return other.UserEmail == UserEmail &&
        other.Message == Message &&
        other.TimeStamp == TimeStamp &&
        other.Likes == Likes &&
        other.Path == Path;
  }

  @override
  int get hashCode {
    return UserEmail.hashCode ^
        Message.hashCode ^
        TimeStamp.hashCode ^
        Likes.hashCode ^
        Path.hashCode;
  }
}

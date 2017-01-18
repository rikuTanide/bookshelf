import 'dart:convert';

class User {
  final String uid;
  final String userID;

  final HtmlEscape sanitizer = new HtmlEscape();

  User(this.uid, this.userID);

  String getEscapedID() => userID != null ? sanitizer.convert(userID) : null;
}
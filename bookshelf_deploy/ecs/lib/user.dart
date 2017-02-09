import 'dart:convert';

class User {
  final String uid;
  final String userID;
  final String trackingID;

  final HtmlEscape sanitizer = new HtmlEscape();

  User(this.uid, this.userID,this.trackingID);

  String getEscapedID() => userID != null ? sanitizer.convert(userID) : null;
}
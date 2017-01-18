import 'dart:convert';

class Book {
  final String title;
  final String author;
  final DateTime datetime;

  final HtmlEscape sanitizer = new HtmlEscape();

  Book(this.title, this.author, this.datetime);

  String getEscapedTitle() => sanitizer.convert(title);

  String getEscapedAuthor() => sanitizer.convert(author);

  String getFormattedDateTime() => "${datetime.year}/${datetime.month}";
}
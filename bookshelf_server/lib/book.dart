import 'dart:convert';

class Book {
  final String title;
  final String author;
  final DateTime datetime;
  final String id;

  final HtmlEscape sanitizer = new HtmlEscape();

  Book(this.id, this.title, this.author, this.datetime);

  String getEscapedTitle() => sanitizer.convert(title);

  String getEscapedAuthor() => sanitizer.convert(author);

  String getFormattedDateTime() => "${datetime.year}/${datetime.month}";
}

class BookRead {
  Book book;
  bool isRead;
}

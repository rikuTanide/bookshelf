import 'dart:convert';

class Book {
  final String title;
  final String author;
  final DateTime datetime;
  final String id;
  final String review;
  final String image;
  final String asin;

  final HtmlEscape sanitizer = new HtmlEscape();

  Book(this.id, this.title, this.author, this.datetime, this.review, this.image,
      this.asin);

  String getEscapedTitle() => sanitizer.convert(title);

  String getEscapedAuthor() => sanitizer.convert(author);

  String getFormattedDateTime() => "${datetime.year}/${datetime.month}";
}

class BookRead {
  Book book;
  bool isRead;
  bool isReviewRequest;

  BookRead(this.book, this.isRead, this.isReviewRequest);
}

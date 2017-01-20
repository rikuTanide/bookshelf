import 'package:bookshelf_server/month.dart';
import 'package:bookshelf_server/book.dart';
import 'package:bookshelf_server/year.dart';
import 'dart:math' as math;

class BookAnchor {
  List<Year> createBookAnchor(List<Book> books, int activeYear,
      int activeMonth) {
    return _getYears(books, activeYear, activeMonth).toList()
      ..sort((y1, y2) => y1.year.compareTo(y2.year));
  }

  Iterable<Year> _getYears(List<Book> books, int activeYear,
      int activeMonth) sync* {
    for (var y = 2014; y < 2018; y ++) {
      yield new Year()
        ..year = y
        ..isActive = y == activeYear
        ..isEnable = _getEnableYear(books, y)
        ..months = _getMonths(books, y, y == activeYear, activeMonth).toList();
    }
  }

  Iterable<Month> _getMonths(List<Book> books, int year, bool isActiveYear,
      int activeMonth) sync* {
    for (var m = 1; m < 13; m ++) {
      yield new Month()
        ..month = m
        ..isActive = isActiveYear && m == activeMonth
        ..isEnable = _getEnableMonth(books, year, m);
    }
  }

  bool _getEnableMonth(List<Book> books, int year, int m) {
    return books
        .where((b) => b.datetime.year == year)
        .where((b) => b.datetime.month == m)
        .isNotEmpty;
  }

  int getMaxYear(List<Book> books) =>
      books
          .map((book) => book.datetime.year)
          .fold(2014, (y1, y2) => math.max(y1, y2));

  int getMaxMonth(List<Book> books, int year) => books
      .where((b) => b.datetime.year == year)
      .map((b) => b.datetime.month)
      .fold(1, (m1, m2) => math.max(m1, m2));

  bool _getEnableYear(List<Book> books, int year) =>
      books.any((Book b) => b.datetime.year == year);

}
import 'package:collection/collection.dart';

Function eq = const ListEquality().equals;

class Top {
  List<BookLogger> bookLoggers;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is Top &&
        eq(this.bookLoggers , other.bookLoggers);
  }

  @override
  int get hashCode {
    return bookLoggers.hashCode;
  }

  @override
  String toString() {
    return 'Top{bookLoggers: $bookLoggers}';
  }
}


class BookLogger {
  String username;
  int year, month;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is BookLogger &&
        this.username == other.username &&
        this.year == other.year &&
        this.month == other.month;
  }

  @override
  int get hashCode {
    return username.hashCode ^ year.hashCode ^ month.hashCode;
  }

  @override
  String toString() {
    return 'BookLogger{username: $username, year: $year, month: $month}';
  }
}
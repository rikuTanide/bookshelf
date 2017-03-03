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
        eq(this.bookLoggers == other.bookLoggers);
  }

  @override
  int get hashCode {
    return bookLoggers.hashCode;
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
}
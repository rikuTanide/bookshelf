library bookshelf_client.types.top;

import 'package:bookshelf_client/types/share.dart';

class TopProps {
  final HeaderLinkParams headerLinkParams;
  final List<BookLogger> bookLoggers;
  final bool isLoading;

  TopProps(this.headerLinkParams, this.bookLoggers, this.isLoading);

}

class BookLogger {
  final String name;

  final int latestYear, latestMonth;

  BookLogger(this.name, this.latestYear, this.latestMonth);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is BookLogger &&
        this.name == other.name &&
        this.latestYear == other.latestYear &&
        this.latestMonth == other.latestMonth;
  }

  @override
  int get hashCode {
    return name.hashCode ^ latestYear.hashCode ^ latestMonth.hashCode;
  }
}
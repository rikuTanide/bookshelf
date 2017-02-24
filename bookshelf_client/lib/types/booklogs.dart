library bookshelf_client.types.booklogs;

import 'package:bookshelf_client/types/share.dart';

class BookLogsProps {
  final HeaderLinkParams headerLinkParams;
  final int year, month;

  final List<YearSelectState> yearSelectStates;
  final List<MonthEnabled> monthEnableds;

  final bool isLoading;

  final String username;

  final List<BookLog> booklogs;

  BookLogsProps(this.headerLinkParams, this.year,
      this.month, this.yearSelectStates, this.monthEnableds, this.isLoading,
      this.username,
      this.booklogs);

}

class BookLog {
  final String id;
  final BookAttrs bookAttrs;
  final bool hasReview;
  final String review;
  final bool isRead, isSaving;

  BookLog(this.id, this.bookAttrs, this.hasReview, this.review,
      this.isRead, this.isSaving);

}

class MonthEnabled {
  final int year;
  final int month;
  final bool active;
  final bool enabled;

  MonthEnabled(this.year, this.month, this.active, this.enabled);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is MonthEnabled &&
        this.year == other.year &&
        this.month == other.month &&
        this.active == other.active &&
        this.enabled == other.enabled;
  }

  @override
  int get hashCode {
    return year.hashCode ^ month.hashCode ^ active.hashCode ^ enabled.hashCode;
  }

  @override
  String toString() {
    return 'MonthEnabled{year: $year, month: $month, active: $active, enabled: $enabled}';
  }

}
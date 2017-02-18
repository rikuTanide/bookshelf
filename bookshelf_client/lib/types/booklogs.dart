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
  final bool isRead, isSaving;

  BookLog(this.id, this.bookAttrs, this.isRead, this.isSaving);

}
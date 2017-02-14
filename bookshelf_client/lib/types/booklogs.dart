library bookshelf_client.types.booklogs;

import 'package:bookshelf_client/types/share.dart';

class BookLogs {
  final String username;
  final int latest_year, latest_month;
  final int year, month;

  final List<YearSelectState> yearSelectStates;
  final List<MonthEnabled> monthEnableds;

  final bool isLoading;

  final List<BookLog> booklogs;

}

class BookLog {
  final String id;
  final BookAttrs bookAttrs;
  final bool isRead, isSaving;

}
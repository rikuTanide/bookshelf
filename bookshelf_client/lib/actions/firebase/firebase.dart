import 'dart:async';

import 'package:bookshelf_client/model/my_booklogs.dart' as myBookLog;
import 'package:bookshelf_client/model/booklogs.dart' as bookLog;
import 'package:bookshelf_client/model/top.dart';

abstract class FirebaseFetchUserList {
  Future<List<BookLogger>> fetchUserList();
}

abstract class FirebaseFetchMyBookLog {
  Future<List<myBookLog.BookLog>> fetchBookLogList();
}

abstract class FirebaseFetchBookLogs {
  Future<List<bookLog.BookLog>> fetchBookLogList(String userid, int year,
      int month);
}
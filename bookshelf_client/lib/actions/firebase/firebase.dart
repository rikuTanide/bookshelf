import 'dart:async';

import 'package:bookshelf_client/model/my_booklogs.dart';
import 'package:bookshelf_client/model/top.dart';

abstract class FirebaseFetchUserList {
  Future<List<BookLogger>> fetchUserList();
}

abstract class FirebaseFetchMyBookLog {
  Future<List<BookLog>> fetchBookLogList();
}
import 'dart:async';

import 'package:bookshelf_client/model/my_booklogs.dart' as myBookLog;
import 'package:bookshelf_client/model/booklogs.dart' as mBookLog;
import 'package:bookshelf_client/model/top.dart' as mTop;
import 'package:bookshelf_client/model/my_stocks.dart' as mMyStocks;
import 'package:bookshelf_client/model/stocks.dart' as mStocks;

abstract class FirebaseFetchUserList {
  Future<List<mTop.BookLogger>> fetchUserList();
}

abstract class FirebaseFetchMyBookLog {
  Future<List<myBookLog.BookLog>> fetchBookLogList();
}

abstract class FirebaseFetchBookLogs {
  Future<List<mBookLog.BookLog>> fetchBookLogList(String userid, int year,
      int month);
}

abstract class FirebaseFetchMyStocks {
  Future<List<mMyStocks.Stock>> fetchMyStockList();
}

abstract class FirebaseFetchStocks {
  Future<List<mStocks.Stock>> fetchStockList();
}
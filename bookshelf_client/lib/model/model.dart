import 'package:bookshelf_client/model/book_logs.dart';
import 'package:bookshelf_client/model/my_booklogs.dart';
import 'package:bookshelf_client/model/my_stocks.dart';
import 'package:bookshelf_client/model/stocks.dart';
import 'package:bookshelf_client/model/top.dart';

class Model {

  String username;
  String uid;
  DateTime now;

  Top top;
  MyBookLogs myBookLog;
  MyStocks myStocks;
  BookLogs bookLogs;
  Stocks stocks;
}

import 'package:bookshelf_client/model/booklogs.dart';
import 'package:bookshelf_client/model/my_booklogs.dart';
import 'package:bookshelf_client/model/my_stocks.dart';
import 'package:bookshelf_client/model/setting.dart';
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
  Setting setting;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is Model &&
        this.username == other.username &&
        this.uid == other.uid &&
        this.now == other.now &&
        this.top == other.top &&
        this.myBookLog == other.myBookLog &&
        this.myStocks == other.myStocks &&
        this.bookLogs == other.bookLogs &&
        this.stocks == other.stocks &&
        this.setting == other.setting;
  }

  @override
  int get hashCode {
    return username.hashCode ^ uid.hashCode ^ now.hashCode ^ top
        .hashCode ^ myBookLog.hashCode ^ myStocks.hashCode ^ bookLogs
        .hashCode ^ stocks.hashCode ^ setting.hashCode;
  }

  @override
  String toString() {
    return 'Model{username: $username, uid: $uid, now: $now, top: $top, myBookLog: $myBookLog, myStocks: $myStocks, bookLogs: $bookLogs, stocks: $stocks, setting: $setting}';
  }

  Model(this.username, this.uid, this.now, {this.top, this.myBookLog,
  this.myStocks, this.bookLogs, this.stocks, this.setting});


}

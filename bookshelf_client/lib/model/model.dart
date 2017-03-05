import 'package:bookshelf_client/model/booklogs.dart';
import 'package:bookshelf_client/model/my_booklogs.dart';
import 'package:bookshelf_client/model/my_stocks.dart';
import 'package:bookshelf_client/model/setting.dart';
import 'package:bookshelf_client/model/stocks.dart';
import 'package:bookshelf_client/model/top.dart';

class Model {

  final String username;
  final String uid;
  final DateTime now;

  final Top top;
  final MyBookLogs myBookLog;
  final MyStocks myStocks;
  final BookLogs bookLogs;
  final Stocks stocks;
  final Setting setting;

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

  Model.pageUpdate(Model model, {this.top, this.myBookLog,
  this.myStocks, this.bookLogs, this.stocks, this.setting})
      :this.username = model.username,
        this.uid = model.uid,
        this.now = model.now;

}

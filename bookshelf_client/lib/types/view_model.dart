import 'package:bookshelf_client/types/booklogs.dart';
import 'package:bookshelf_client/types/my_booklogs.dart';
import 'package:bookshelf_client/types/my_stocks.dart';
import 'package:bookshelf_client/types/setting.dart';
import 'package:bookshelf_client/types/stocks.dart';
import 'package:bookshelf_client/types/top.dart';

class ViewModel {
  final TopProps top;
  final MyBookLogsProps myBookLogs;
  final BookLogsProps bookLogs;
  final MyStocksProps myStocks;
  final StocksProps stocks;
  final SettingProps setting;

  ViewModel({this.top,
  this.myBookLogs,
  this.bookLogs,
  this.myStocks,
  this.stocks, this.setting});
}


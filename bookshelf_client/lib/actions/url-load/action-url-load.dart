import 'dart:async';
import 'package:bookshelf_client/actions/firebase/firebase.dart';
import 'package:bookshelf_client/actions/url-load/parse-url.dart';
import 'package:bookshelf_client/model/model.dart';
import 'package:bookshelf_client/model/top.dart' as mTop;
import 'package:bookshelf_client/model/my_booklogs.dart' as mMyBookLogs;
import 'package:bookshelf_client/model/booklogs.dart' as mBookLogs;
import 'package:bookshelf_client/model/my_stocks.dart' as mMyStocks;
import 'package:bookshelf_client/services/model_service.dart';

class URLLoadAction {

  final ModelService modelService;
  final FirebaseFetchUserList ffUserList;
  final FirebaseFetchMyBookLog ffMyBookLogs;
  final FirebaseFetchBookLogs ffBookLogs;
  final FirebaseFetchMyStocks ffMyStocks;

  URLLoadAction(this.modelService, this.ffUserList, this.ffMyBookLogs,
      this.ffBookLogs, this.ffMyStocks);

  Future onLoad(URLParams params) async {
    if (params.top != null) {
      var top1 = new mTop.Top();
      modelService.model = new Model.pageUpdate(modelService.model, top: top1);
      var bookLogger = await ffUserList.fetchUserList();
      var top2 = new mTop.Top()
        ..bookLoggers = bookLogger;
      modelService.model = new Model.pageUpdate(modelService.model, top: top2);
    } else if (params.myBookLogs != null) {
      var param = params.myBookLogs;
      var myBookLogs1 = new mMyBookLogs.MyBookLogs()
        ..pageMonth = new DateTime(param.year, param.month, 1)
        ..selectMonth = new DateTime(param.year, param.month, 1);
      modelService.model =
      new Model.pageUpdate(modelService.model, myBookLog: myBookLogs1);
      var myBookLogs2 = new mMyBookLogs.MyBookLogs()
        ..pageMonth = new DateTime(param.year, param.month, 1)
        ..selectMonth = new DateTime(param.year, param.month, 1);
      myBookLogs2.bookLogs = await ffMyBookLogs.fetchBookLogList();
      modelService.model =
      new Model.pageUpdate(modelService.model, myBookLog: myBookLogs2);
    } else if (params.bookLogs != null) {
      var param = params.bookLogs;
      var bookLogs1 = new mBookLogs.BookLogs()
        ..pageMonth = new DateTime(param.year, param.month)
        ..selectMonth = new DateTime(param.year, param.month);
      modelService.model =
      new Model.pageUpdate(modelService.model, bookLogs: bookLogs1);
      var bookLogs2 = new mBookLogs.BookLogs()
        ..pageMonth = new DateTime(param.year, param.month)
        ..selectMonth = new DateTime(param.year, param.month);
      bookLogs2.booklogs = await ffBookLogs.fetchBookLogList(
          param.username, param.year, param.month);
      modelService.model =
      new Model.pageUpdate(modelService.model, bookLogs: bookLogs2);
    } else if (params.myStocks != null) {
      var myStocks1 = new mMyStocks.MyStocks();
      modelService.model =
      new Model.pageUpdate(modelService.model, myStocks: myStocks1);
      var myStocks2 = new mMyStocks.MyStocks()
        ..stocks = await ffMyStocks.fetchMyStockList();
      modelService.model =
      new Model.pageUpdate(modelService.model, myStocks: myStocks2);
    }
  }

}
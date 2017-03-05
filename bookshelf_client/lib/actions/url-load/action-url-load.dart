import 'dart:async';
import 'package:bookshelf_client/actions/firebase/firebase.dart';
import 'package:bookshelf_client/actions/url-load/parse-url.dart';
import 'package:bookshelf_client/model/model.dart';
import 'package:bookshelf_client/model/top.dart' as mTop;
import 'package:bookshelf_client/model/my_booklogs.dart' as mBookLogs;
import 'package:bookshelf_client/services/model_service.dart';

class URLLoadAction {

  final ModelService modelService;
  final FirebaseFetchUserList ffUserList;
  final FirebaseFetchMyBookLog ffMyBookLogs;

  URLLoadAction(this.modelService, this.ffUserList, this.ffMyBookLogs);

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
      var myBookLogs1 = new mBookLogs.MyBookLogs()
        ..pageMonth = new DateTime(param.year, param.month, 1)
        ..selectMonth = new DateTime(param.year, param.month, 1);
      modelService.model =
      new Model.pageUpdate(modelService.model, myBookLog: myBookLogs1);
      var myBookLogs2 = new mBookLogs.MyBookLogs()
        ..pageMonth = new DateTime(param.year, param.month, 1)
        ..selectMonth = new DateTime(param.year, param.month, 1);
      myBookLogs2.bookLogs = await ffMyBookLogs.fetchBookLogList();
      modelService.model =
      new Model.pageUpdate(modelService.model, myBookLog: myBookLogs2);
    }
  }

}
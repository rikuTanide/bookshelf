import 'dart:async';
import 'package:bookshelf_client/actions/firebase/firebase.dart';
import 'package:bookshelf_client/actions/url-load/parse-url.dart';
import 'package:bookshelf_client/model/model.dart';
import 'package:bookshelf_client/model/top.dart' as m;

class URLLoadAction {
  Model model;
  FirebaseFetchUserList firebase;

  Stream onLoad(URLParams params) async* {
    if (params.top != null) {
      clear();
      model.top = new m.Top()
        ..bookLoggers = null;
      model.top.bookLoggers = await firebase.fetchUserList();
    }
  }

  void clear() {
    model
      ..top = null
      ..myBookLog = null
      ..myStocks = null
      ..bookLogs = null
      ..stocks = null
      ..setting = null;
  }

}
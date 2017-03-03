import 'dart:async';
import 'package:bookshelf_client/actions/firebase/firebase.dart';
import 'package:bookshelf_client/actions/url-load/parse-url.dart';
import 'package:bookshelf_client/model/model.dart';
import 'package:bookshelf_client/model/top.dart' as m;
import 'package:bookshelf_client/services/model_service.dart';

class URLLoadAction {

  final ModelService modelService;
  final FirebaseFetchUserList firebase;

  URLLoadAction(this.modelService, this.firebase);

  Future onLoad(URLParams params) async {
    if (params.top != null) {
      var top1 = new m.Top();
      modelService.model = new Model.pageUpdate(modelService.model, top: top1);
      var bookLogger = await firebase.fetchUserList();
      var top2 = new m.Top()
        ..bookLoggers = bookLogger;
      modelService.model = new Model.pageUpdate(modelService.model, top: top2);
    }
  }

}
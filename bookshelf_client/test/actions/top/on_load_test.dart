import '../model_service_mock.dart';
import 'dart:async';
import 'package:bookshelf_client/actions/firebase/firebase.dart';
import 'package:bookshelf_client/actions/url-load/action-url-load.dart';
import 'package:bookshelf_client/actions/url-load/parse-url.dart';
import 'package:bookshelf_client/model/model.dart';
import 'package:bookshelf_client/model/top.dart' as m;
import 'package:test/test.dart';

void main() {
  test("urlで表示してresponseがあったらそれを表示", () async {
    var now = new DateTime.now();
    var model = new Model("", "", now);
    var modelService = new ModelServiceMock()
      ..model = model;
    var firebase = new FirebaseFetchUserListResponseMock();
    var urlLoadAction = new URLLoadAction(modelService, firebase, null);
    var params = new URLParams(top: new Top());
    await urlLoadAction.onLoad(params);
    expect(modelService.modelHistory, equals([
      model,
      new Model("", "", now, top: new m.Top()),
      new Model("", "", now, top: new m.Top()
        ..bookLoggers = [
          new m.BookLogger()
            ..username = "user1"
            ..year = 2017
            ..month = 1,
          new m.BookLogger()
            ..username = "user2"
            ..year = 2017
            ..month = 2,
        ]),
    ]));
  });
}


class FirebaseFetchUserListResponseMock implements FirebaseFetchUserList {
  @override
  Future<List<m.BookLogger>> fetchUserList() => new Future.value(<m.BookLogger>[
    new m.BookLogger()
      ..username = "user1"
      ..year = 2017
      ..month = 1,
    new m.BookLogger()
      ..username = "user2"
      ..year = 2017
      ..month = 2,
  ]);
}

import 'dart:async';
import 'package:bookshelf_client/actions/firebase/firebase.dart';
import 'package:bookshelf_client/actions/url-load/action-url-load.dart';
import 'package:bookshelf_client/actions/url-load/parse-url.dart';
import 'package:bookshelf_client/model/model.dart';
import 'package:bookshelf_client/model/top.dart' as m;
import 'package:test/test.dart';

void main() {
  test("urlで表示", () async {
    var model = new Model();
    var urlLoadAction = new URLLoadAction()
      ..firebase = new FirebaseFetchUserListEmptyMock()
      ..model = model;
    var params = new URLParams(top: new Top());
    var str = urlLoadAction.onLoad(params);
    print(2);
    await str;
    print(4);
    var actual = new Model()
      ..top = new m.Top();
    expect(model, equals(actual));
  });

  test("urlで表示してresponseがあったらそれを表示", () async {
    var model = new Model();
    var urlLoadAction = new URLLoadAction()
      ..firebase = new FirebaseFetchUserListResponseMock()
      ..model = model;
    var params = new URLParams(top: new Top());
    await urlLoadAction.onLoad(params);
    var actual = new Model()
      ..top = new m.Top();
    expect(model, equals(actual));
  });
}


class FirebaseFetchUserListEmptyMock implements FirebaseFetchUserList {
  @override
  Future<List<m.BookLogger>> fetchUserList() => new Completer().future;
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
import '../model_service_mock.dart';
import 'dart:async';
import 'package:bookshelf_client/actions/firebase/firebase.dart';
import 'package:bookshelf_client/actions/url-load/action-url-load.dart';
import 'package:bookshelf_client/actions/url-load/parse-url.dart';
import 'package:bookshelf_client/model/model.dart';
import 'package:bookshelf_client/model/booklogs.dart' as b;
import 'package:test/test.dart';

void main() {
  test("urlで表示してresponseがあったらそれを表示", () async {
    var now = new DateTime(2017, 1, 1);
    var model = new Model("", "", now);
    var modelService = new ModelServiceMock()
      ..model = model;

    var firebase = new FirebaseFetchBookLogsMock();
    var urlLoadAction = new URLLoadAction(modelService, null, null, firebase, null);
    var params = new URLParams(bookLogs: new BookLogs("user1", 2017, 1));
    await urlLoadAction.onLoad(params);
    expect(modelService.modelHistory, equals(<Model>[
      model,
      new Model("", "", now, bookLogs: new b.BookLogs()
        ..pageMonth = new DateTime(2017, 1)
        ..selectMonth = new DateTime(2017, 1)),
      new Model("", "", now, bookLogs: new b.BookLogs()
        ..pageMonth = new DateTime(2017, 1)
        ..selectMonth = new DateTime(2017, 1)
        ..booklogs = [
          new b.BookLog()
            ..id = "id1"
            ..title = "title1"
            ..author = "author1"
            ..image = "image1"
            ..review = "review1"
            ..isRead = false
            ..dateTime = new DateTime(2017, 1),
          new b.BookLog()
            ..id = "id2"
            ..title = "title2"
            ..author = "author2"
            ..image = "image2"
            ..review = "review2"
            ..isRead = false
            ..dateTime = new DateTime(2017, 1),

        ]),

    ]));
  });
}

class FirebaseFetchBookLogsMock implements FirebaseFetchBookLogs {
  @override
  Future<List<b.BookLog>> fetchBookLogList(String userid, int year,
      int month) async => await [
    new b.BookLog()
      ..id = "id1"
      ..title = "title1"
      ..author = "author1"
      ..image = "image1"
      ..review = "review1"
      ..isRead = false
      ..dateTime = new DateTime(2017, 1),
    new b.BookLog()
      ..id = "id2"
      ..title = "title2"
      ..author = "author2"
      ..image = "image2"
      ..review = "review2"
      ..isRead = false
      ..dateTime = new DateTime(2017, 1),
  ];
}
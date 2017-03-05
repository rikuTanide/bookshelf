import '../model_service_mock.dart';
import 'dart:async';
import 'package:bookshelf_client/actions/firebase/firebase.dart';
import 'package:bookshelf_client/actions/url-load/action-url-load.dart';
import 'package:bookshelf_client/actions/url-load/parse-url.dart';
import 'package:bookshelf_client/model/model.dart';
import 'package:bookshelf_client/model/my_booklogs.dart' as m;
import 'package:test/test.dart';

void main() {
  test("urlで表示してresponseがあったらそれを表示", () async {
    var now = new DateTime(2017, 1, 1);
    var model = new Model("", "", now);
    var modelService = new ModelServiceMock()
      ..model = model;
    var firebase = new FirebaseFetchMyBookLogsResponseMock();
    var urlLoadAction = new URLLoadAction(modelService, null, firebase);
    var params = new URLParams(myBookLogs: new MyBookLogs(2017, 1));
    await urlLoadAction.onLoad(params);
    expect(modelService.modelHistory, equals(<Model>[
      model,
      new Model("", "", now, myBookLog: new m.MyBookLogs()
        ..pageMonth = new DateTime(2017, 1)
        ..selectMonth = new DateTime(2017, 1)),
      new Model("", "", now, myBookLog: new m.MyBookLogs()
        ..pageMonth = new DateTime(2017, 1)
        ..selectMonth = new DateTime(2017, 1)
        ..bookLogs = [
          new m.BookLog()
            ..id = "id1"
            ..title = "title1"
            ..author = "author1"
            ..image = "image1"
            ..review = "review1"
            ..dateTime = new DateTime(2017, 1, 1),
          new m.BookLog()
            ..id = "id2"
            ..title = "title2"
            ..author = "author2"
            ..image = "image2"
            ..review = "review2"
            ..dateTime = new DateTime(2017, 1, 1),
        ]),
    ]));
  });
}

class FirebaseFetchMyBookLogsResponseMock implements FirebaseFetchMyBookLog {

  @override
  Future<List<m.BookLog>> fetchBookLogList() async {
    return await [
      new m.BookLog()
        ..id = "id1"
        ..title = "title1"
        ..author = "author1"
        ..image = "image1"
        ..review = "review1"
        ..dateTime = new DateTime(2017, 1, 1),
      new m.BookLog()
        ..id = "id2"
        ..title = "title2"
        ..author = "author2"
        ..image = "image2"
        ..review = "review2"
        ..dateTime = new DateTime(2017, 1, 1),

    ];
  }
}

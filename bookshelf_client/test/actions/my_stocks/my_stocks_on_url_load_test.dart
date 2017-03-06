import '../model_service_mock.dart';
import 'dart:async';
import 'package:bookshelf_client/actions/firebase/firebase.dart';
import 'package:bookshelf_client/actions/url-load/action-url-load.dart';
import 'package:bookshelf_client/actions/url-load/parse-url.dart';
import 'package:bookshelf_client/model/model.dart';
import 'package:bookshelf_client/model/my_stocks.dart' as m;
import 'package:test/test.dart';

void main() {
  test("urlで表示してresponseがあったらそれを表示", () async {
    var now = new DateTime(2017, 1, 1);
    var model = new Model("", "", now);
    var modelService = new ModelServiceMock()
      ..model = model;

    var firebase = new FirebaseFetchMyStocksMock();
    var urlLoadAction = new URLLoadAction(
        modelService, null, null, null, firebase, null);
    var params = new URLParams(myStocks: new MyStocks());
    await urlLoadAction.onLoad(params);

    expect(modelService.modelHistory, equals([
      model,
      new Model("", "", now, myStocks: new m.MyStocks()),
      new Model("", "", now, myStocks: new m.MyStocks()
        ..stocks = [
          new m.Stock()
            ..id = "id1"
            ..title = "title1"
            ..author = "author1"
            ..image = "image1",
          new m.Stock()
            ..id = "id2"
            ..title = "title2"
            ..author = "author2"
            ..image = "image2",
        ]),
    ]));
  });
}

class FirebaseFetchMyStocksMock implements FirebaseFetchMyStocks {

  @override
  Future<List<m.Stock>> fetchMyStockList() async => [
    new m.Stock()
      ..id = "id1"
      ..title = "title1"
      ..author = "author1"
      ..image = "image1",
    new m.Stock()
      ..id = "id2"
      ..title = "title2"
      ..author = "author2"
      ..image = "image2",
  ];

}
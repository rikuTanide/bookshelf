import '../model_service_mock.dart';
import 'dart:async';
import 'package:bookshelf_client/actions/firebase/firebase.dart';
import 'package:bookshelf_client/actions/url-load/action-url-load.dart';
import 'package:bookshelf_client/actions/url-load/parse-url.dart';
import 'package:bookshelf_client/model/model.dart';
import 'package:bookshelf_client/model/stocks.dart' as m;
import 'package:test/test.dart';

void main() {
  test("urlで表示してresponseがあったらそれを表示", () async {
    var now = new DateTime(2017, 1, 1);
    var model = new Model("", "", now);
    var modelService = new ModelServiceMock()
      ..model = model;

    var firebase = new FirebaseFetchStocksMock();
    var urlLoadAction = new URLLoadAction(
        modelService,
        null,
        null,
        null,
        null,
        firebase);
    var params = new URLParams(stocks: new Stocks("user1"));
    await urlLoadAction.onLoad(params);

    expect(modelService.modelHistory, equals([
      model,
      new Model.pageUpdate(modelService.model, stocks: new m.Stocks()),
      new Model.pageUpdate(modelService.model, stocks: new m.Stocks()
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

class FirebaseFetchStocksMock implements FirebaseFetchStocks {

  @override
  Future<List<m.Stock>> fetchStockList() async => [
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

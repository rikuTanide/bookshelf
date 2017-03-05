import 'package:bookshelf_client/types/view_model.dart';
import 'package:bookshelf_client/model/model.dart';
import 'package:bookshelf_client/props/props.dart';
import 'package:test/test.dart';
import 'package:bookshelf_client/model/stocks.dart' as m;
import 'package:bookshelf_client/types/share.dart';
import 'package:bookshelf_client/types/stocks.dart' as v;

ViewModel getViewModel(
    {DateTime now, List<m.Stock> stocks, String savingStockID}) {
  now = now ?? new DateTime.now();
  var mStocks = new m.Stocks()
    ..stocks = stocks
    ..savingStockID = savingStockID;
  var model = new Model("user1", "uid1", now, stocks: mStocks);
  return mapModelToViewModel(model);
}

void main() {
  test("nullでなければnullでない", () {
    var viewModel = getViewModel();
    expect(viewModel.stocks, isNotNull);
  });

  group("stockが", () {
    test("nullならisLoading", () {
      var viewModel = getViewModel();
      expect(viewModel.stocks.isLoading, isTrue);
    });
    test("nullでないならisLoadingがfalse", () {
      var viewModel = getViewModel(stocks: []);
      expect(viewModel.stocks.isLoading, isFalse);
    });
  });

  group("それオススメ", () {
    test("セーブ中", () {
      var stock1 = new m.Stock()
        ..id = "stock1"
        ..title = "title1"
        ..author = "author1"
        ..image = "img.png"
        ..iRecommend = true;
      var stock2 = new m.Stock()
        ..id = "stock2"
        ..title = "title2"
        ..author = "author2"
        ..image = "img.png"
        ..iRecommend = true;

      var stocks = [stock1, stock2];
      var viewModel = getViewModel(stocks: stocks, savingStockID: "stock1");
      expect(
          viewModel.stocks.stocks,
          equals([
            new v.Stock("stock1", new BookAttrs("title1", "author1", "img.png"),
                true, true),
            new v.Stock("stock2", new BookAttrs("title2", "author2", "img.png"),
                true, false),
          ]));
    });
    test("セーブ中でない", () {
      var stock1 = new m.Stock()
        ..id = "stock1"
        ..title = "title1"
        ..author = "author1"
        ..image = "img.png"
        ..iRecommend = true;
      var stock2 = new m.Stock()
        ..id = "stock2"
        ..title = "title2"
        ..author = "author2"
        ..image = "img.png"
        ..iRecommend = true;

      var stocks = [stock1, stock2];
      var viewModel = getViewModel(stocks: stocks);
      expect(
          viewModel.stocks.stocks,
          equals([
            new v.Stock("stock1", new BookAttrs("title1", "author1", "img.png"),
                true, false),
            new v.Stock("stock2", new BookAttrs("title2", "author2", "img.png"),
                true, false),
          ]));
    });
  });

  group("それオススメしてない", () {
    test("セーブ中", () {
      var stock1 = new m.Stock()
        ..id = "stock1"
        ..title = "title1"
        ..author = "author1"
        ..image = "img.png"
        ..iRecommend = false;
      var stock2 = new m.Stock()
        ..id = "stock2"
        ..title = "title2"
        ..author = "author2"
        ..image = "img.png"
        ..iRecommend = false;

      var stocks = [stock1, stock2];
      var viewModel = getViewModel(stocks: stocks, savingStockID: "stock1");
      expect(
          viewModel.stocks.stocks,
          equals([
            new v.Stock("stock1", new BookAttrs("title1", "author1", "img.png"),
                false, true),
            new v.Stock("stock2", new BookAttrs("title2", "author2", "img.png"),
                false, false),
          ]));
    });
    test("セーブ中でない", () {
      var stock1 = new m.Stock()
        ..id = "stock1"
        ..title = "title1"
        ..author = "author1"
        ..image = "img.png"
        ..iRecommend = false;
      var stock2 = new m.Stock()
        ..id = "stock2"
        ..title = "title2"
        ..author = "author2"
        ..image = "img.png"
        ..iRecommend = false;

      var stocks = [stock1, stock2];
      var viewModel = getViewModel(stocks: stocks);
      expect(
          viewModel.stocks.stocks,
          equals([
            new v.Stock("stock1", new BookAttrs("title1", "author1", "img.png"),
                false, false),
            new v.Stock("stock2", new BookAttrs("title2", "author2", "img.png"),
                false, false),
          ]));
    });
  });
}

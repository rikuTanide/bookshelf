import 'package:bookshelf_client/types/view_model.dart';
import 'package:bookshelf_client/model/model.dart';
import 'package:bookshelf_client/props/props.dart';
import 'package:test/test.dart';
import 'package:bookshelf_client/model/my_stocks.dart' as m;
import 'package:bookshelf_client/types/my_stocks.dart' as v;
import 'package:bookshelf_client/types/share.dart';

ViewModel getViewModel({DateTime now, List<m.Stock> stocks, m.Editing editing, m
    .TitleSuggestions titleSuggests, m.AuthorSuggestions authorSuggestions}) {
  now = now ?? new DateTime.now();
  var myStocks = new m.MyStocks()
    ..stocks = stocks
    ..editing = editing
    ..titleSuggestions = titleSuggests
    ..authorSuggestions = authorSuggestions;
  var model = new Model("user1", "uid1", now, myStocks: myStocks);
  return mapModelToViewModel(model);
}

void main() {
  group("model.myStocksが", () {
    test("nullでないならnullでない", () {
      var viewModel = getViewModel();
      expect(viewModel.myStocks, isNotNull);
    });
  });

  test("stocksがnullならisLoadingがtrue", () {
    var viewModel = getViewModel(stocks: null);
    expect(viewModel.myStocks.isLoading, isTrue);
  });
  test("stocksがnullでないならnullでないisLoadingがfalse", () {
    var viewModel = getViewModel(stocks: []);
    expect(viewModel.myStocks.isLoading, isFalse);
  });

  group("編集中", () {
    test("編集中ならタイトルと著者とimageが編集中の値になる", () {
      var editing = new m.Editing()
        ..logID = "id1"
        ..title = "title1..."
        ..author = "autor1..."
        ..image = "img.png..."
        ..isAdding = false
        ..isSaving = false
        ..isDeleting = false;
      var stocks = [
        new m.Stock()
          ..id = "id1"
          ..title = "title1"
          ..author = "autor1"
          ..image = "img.png"
      ];
      var viewModel = getViewModel(editing: editing, stocks: stocks);
      expect(
          viewModel.myStocks.stocks,
          equals([
            new v.Stock(
                new BookAttrs("title1...", "autor1...", "img.png..."),
                new TitleSuggestions(false, false, []),
                new AuthorSuggestions(false, false, []),
                true,
                true,
                false,
                false,
                false)
          ]));
    });
    test("IDが一致している行だけisEditingがtrueになる", () {
      var editing = new m.Editing()
        ..logID = "id1"
        ..title = "title1..."
        ..author = "autor1..."
        ..image = "img.png..."
        ..isAdding = false
        ..isSaving = false
        ..isDeleting = false;
      var stocks = [
        new m.Stock()
          ..id = "id1"
          ..title = "title1"
          ..author = "autor1"
          ..image = "img.png",
        new m.Stock()
          ..id = "id2"
          ..title = "title2"
          ..author = "autor2"
          ..image = "img.png",

      ];
      var viewModel = getViewModel(editing: editing, stocks: stocks);
      expect(
          viewModel.myStocks.stocks,
          equals([
            new v.Stock(
                new BookAttrs("title1...", "autor1...", "img.png..."),
                new TitleSuggestions(false, false, []),
                new AuthorSuggestions(false, false, []),
                true,
                true,
                false,
                false,
                false),
            new v.Stock(
                new BookAttrs("title2", "autor2", "img.png"),
                new TitleSuggestions(false, false, []),
                new AuthorSuggestions(false, false, []),
                false,
                false,
                false,
                false,
                false),

          ]));
    });
    test("追加中なら行が増える", () {
      var editing = new m.Editing()
        ..logID = null
        ..title = "title..."
        ..author = "autor..."
        ..image = "img.png..."
        ..isAdding = true
        ..isSaving = false
        ..isDeleting = false;
      var stocks = [
        new m.Stock()
          ..id = "id1"
          ..title = "title1"
          ..author = "autor1"
          ..image = "img.png"
      ];
      var viewModel = getViewModel(editing: editing, stocks: stocks);
      expect(
          viewModel.myStocks.stocks,
          equals([
            new v.Stock(
                new BookAttrs("title...", "autor...", "img.png..."),
                new TitleSuggestions(false, false, []),
                new AuthorSuggestions(false, false, []),
                true,
                true,
                false,
                false,
                false),
            new v.Stock(
                new BookAttrs("title1", "autor1", "img.png"),
                new TitleSuggestions(false, false, []),
                new AuthorSuggestions(false, false, []),
                false,
                false,
                false,
                false,
                false),

          ]));
    });
    test("追加中でないなら行が増えない", () {
      var editing = new m.Editing()
        ..logID = "id1"
        ..title = "title1..."
        ..author = "autor1..."
        ..image = "img.png..."
        ..isAdding = false
        ..isSaving = false
        ..isDeleting = false;
      var stocks = [
        new m.Stock()
          ..id = "id1"
          ..title = "title1"
          ..author = "autor1"
          ..image = "img.png"
      ];
      var viewModel = getViewModel(editing: editing, stocks: stocks);
      expect(
          viewModel.myStocks.stocks,
          equals([
            new v.Stock(
                new BookAttrs("title1...", "autor1...", "img.png..."),
                new TitleSuggestions(false, false, []),
                new AuthorSuggestions(false, false, []),
                true,
                true,
                false,
                false,
                false),

          ]));
    });
    test("セーブ中ならisSavingでisLocking", () {
      var editing = new m.Editing()
        ..logID = "id1"
        ..title = "title1..."
        ..author = "autor1..."
        ..image = "img.png..."
        ..isAdding = false
        ..isSaving = true
        ..isDeleting = false;
      var stocks = [
        new m.Stock()
          ..id = "id1"
          ..title = "title1"
          ..author = "autor1"
          ..image = "img.png"
      ];
      var viewModel = getViewModel(editing: editing, stocks: stocks);
      expect(
          viewModel.myStocks.stocks,
          equals([
            new v.Stock(
                new BookAttrs("title1...", "autor1...", "img.png..."),
                new TitleSuggestions(false, false, []),
                new AuthorSuggestions(false, false, []),
                true,
                true,
                true,
                true,
                false),

          ]));
    });
    test("削除中ならisLockingでisDeleting", () {
      var editing = new m.Editing()
        ..logID = "id1"
        ..title = "title1..."
        ..author = "autor1..."
        ..image = "img.png..."
        ..isAdding = false
        ..isSaving = false
        ..isDeleting = true;
      var stocks = [
        new m.Stock()
          ..id = "id1"
          ..title = "title1"
          ..author = "autor1"
          ..image = "img.png"
      ];
      var viewModel = getViewModel(editing: editing, stocks: stocks);
      expect(
          viewModel.myStocks.stocks,
          equals([
            new v.Stock(
                new BookAttrs("title1...", "autor1...", "img.png..."),
                new TitleSuggestions(false, false, []),
                new AuthorSuggestions(false, false, []),
                true,
                true,
                true,
                false,
                true),

          ]));
    });
    test("タイトルの候補表示中なら", () {
      var editing = new m.Editing()
        ..logID = "id1"
        ..title = "title1..."
        ..author = "autor1..."
        ..image = "img.png..."
        ..isAdding = false
        ..isSaving = false
        ..isDeleting = true;
      var stocks = [
        new m.Stock()
          ..id = "id1"
          ..title = "title1"
          ..author = "autor1"
          ..image = "img.png"
      ];
      var titleSuggests = new m.TitleSuggestions()
        ..titleSuggestionsResult = ["候補１", "候補２"];
      var viewModel = getViewModel(
          editing: editing, stocks: stocks, titleSuggests: titleSuggests);
      expect(
          viewModel.myStocks.stocks,
          equals([
            new v.Stock(
                new BookAttrs("title1...", "autor1...", "img.png..."),
                new TitleSuggestions(true, false, ["候補１", "候補２"]),
                new AuthorSuggestions(false, false, []),
                true,
                true,
                true,
                false,
                true),

          ]));
    });
    test("タイトルの候補ロード中なら", () {
      var editing = new m.Editing()
        ..logID = "id1"
        ..title = "title1..."
        ..author = "autor1..."
        ..image = "img.png..."
        ..isAdding = false
        ..isSaving = false
        ..isDeleting = true;
      var stocks = [
        new m.Stock()
          ..id = "id1"
          ..title = "title1"
          ..author = "autor1"
          ..image = "img.png"
      ];
      var titleSuggests = new m.TitleSuggestions()
        ..titleSuggestionsResult = null;
      var viewModel = getViewModel(
          editing: editing, stocks: stocks, titleSuggests: titleSuggests);
      expect(
          viewModel.myStocks.stocks,
          equals([
            new v.Stock(
                new BookAttrs("title1...", "autor1...", "img.png..."),
                new TitleSuggestions(true, true, []),
                new AuthorSuggestions(false, false, []),
                true,
                true,
                true,
                false,
                true),

          ]));
    });
    test("著者の候補表示中なら", () {
      var editing = new m.Editing()
        ..logID = "id1"
        ..title = "title1..."
        ..author = "autor1..."
        ..image = "img.png..."
        ..isAdding = false
        ..isSaving = false
        ..isDeleting = true;
      var stocks = [
        new m.Stock()
          ..id = "id1"
          ..title = "title1"
          ..author = "autor1"
          ..image = "img.png"
      ];
      var authorSuggestions = new m.AuthorSuggestions()
        ..authorSuggestionsResults = [
          new m.AuthorSuggestion()
            ..author = "author_s1"
            ..image = "img_s1",
          new m.AuthorSuggestion()
            ..author = "author_s2"
            ..image = "img_s2",
        ];
      var viewModel = getViewModel(editing: editing,
          stocks: stocks,
          authorSuggestions: authorSuggestions);
      expect(
          viewModel.myStocks.stocks,
          equals([
            new v.Stock(
                new BookAttrs("title1...", "autor1...", "img.png..."),
                new TitleSuggestions(false, false, []),
                new AuthorSuggestions(true, false, [
                  new AuthorSuggest("author_s1", "img_s1"),
                  new AuthorSuggest("author_s2", "img_s2"),
                ]),
                true,
                true,
                true,
                false,
                true),

          ]));
    });
    test("著者の候補ロード中なら", () {
      var editing = new m.Editing()
        ..logID = "id1"
        ..title = "title1..."
        ..author = "autor1..."
        ..image = "img.png..."
        ..isAdding = false
        ..isSaving = false
        ..isDeleting = true;
      var stocks = [
        new m.Stock()
          ..id = "id1"
          ..title = "title1"
          ..author = "autor1"
          ..image = "img.png"
      ];
      var authorSuggestions = new m.AuthorSuggestions()
        ..authorSuggestionsResults = null;
      var viewModel = getViewModel(editing: editing,
          stocks: stocks,
          authorSuggestions: authorSuggestions);
      expect(
          viewModel.myStocks.stocks,
          equals([
            new v.Stock(
                new BookAttrs("title1...", "autor1...", "img.png..."),
                new TitleSuggestions(false, false, []),
                new AuthorSuggestions(true, true, []),
                true,
                true,
                true,
                false,
                true),

          ]));
    });
    test("タイトルが空文字ならinvalid", () {
      var editing = new m.Editing()
        ..logID = "id1"
        ..title = ""
        ..author = "autor1..."
        ..image = "img.png..."
        ..isAdding = false
        ..isSaving = false
        ..isDeleting = false;
      var stocks = [
        new m.Stock()
          ..id = "id1"
          ..title = "title1"
          ..author = "autor1"
          ..image = "img.png"
      ];
      var authorSuggestions = new m.AuthorSuggestions()
        ..authorSuggestionsResults = null;
      var viewModel = getViewModel(editing: editing,
          stocks: stocks,
          authorSuggestions: authorSuggestions);
      expect(
          viewModel.myStocks.stocks,
          equals([
            new v.Stock(
                new BookAttrs("", "autor1...", "img.png..."),
                new TitleSuggestions(false, false, []),
                new AuthorSuggestions(true, true, []),
                true,
                false,
                false,
                false,
                false),

          ]));
    });
    test("著者が空文字ならinvalid", () {
      var editing = new m.Editing()
        ..logID = "id1"
        ..title = "title1..."
        ..author = ""
        ..image = "img.png..."
        ..isAdding = false
        ..isSaving = false
        ..isDeleting = false;
      var stocks = [
        new m.Stock()
          ..id = "id1"
          ..title = "title1"
          ..author = "autor1"
          ..image = "img.png"
      ];
      var authorSuggestions = new m.AuthorSuggestions()
        ..authorSuggestionsResults = null;
      var viewModel = getViewModel(editing: editing,
          stocks: stocks,
          authorSuggestions: authorSuggestions);
      expect(
          viewModel.myStocks.stocks,
          equals([
            new v.Stock(
                new BookAttrs("title1...", "", "img.png..."),
                new TitleSuggestions(false, false, []),
                new AuthorSuggestions(true, true, []),
                true,
                false,
                false,
                false,
                false),

          ]));
    });
  });
}

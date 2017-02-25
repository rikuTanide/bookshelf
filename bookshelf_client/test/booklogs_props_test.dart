import 'package:bookshelf_client/model/booklogs.dart' as m;
import 'package:bookshelf_client/model/model.dart';
import 'package:bookshelf_client/props/props.dart';
import 'package:bookshelf_client/types/share.dart';
import 'package:bookshelf_client/types/view_model.dart';
import 'package:bookshelf_client/types/booklogs.dart' as v;
import 'package:test/test.dart';

ViewModel getViewModel(
    {DateTime now,
    DateTime pageMonth,
    DateTime selectMonth,
    List<m.BookLog> bookLogs,
    String saving}) {
  now = now ?? new DateTime.now();
  pageMonth = pageMonth ?? new DateTime.now();
  selectMonth = selectMonth ?? new DateTime.now();
  var model = new Model()
    ..bookLogs = (new m.BookLogs()
      ..pageMonth = pageMonth
      ..selectMonth = selectMonth
      ..booklogs = bookLogs
      ..savingBookID = saving)
    ..now = now;
  return mapModelToViewModel(model);
}

void main() {
  test("nullでなければnullでない", () {
    var viewModel = getViewModel();
    expect(viewModel.bookLogs, isNotNull);
  });

  group("今日が2017/2/1なら", () {
    var viewModel = getViewModel(now: new DateTime(2017, 2, 1));
    test("年が2017", () {
      expect(viewModel.bookLogs.year, equals(2017));
    });
    test("月が2", () {
      expect(viewModel.bookLogs.month, equals(2));
    });
  });

  group("年のタブ", () {
    group("ページが2017年で", () {
      test("selectが2017年なら2017がselectedになる", () {
        var viewModel =
            getViewModel(selectMonth: new DateTime(2017, 2, 1), bookLogs: []);
        expect(
            viewModel.bookLogs.yearSelectStates,
            equals([
              new YearSelectState(2014, false),
              new YearSelectState(2015, false),
              new YearSelectState(2016, false),
              new YearSelectState(2017, true),
            ]));
      });
    });
  });
  group("月のタブ", () {
    group("ページが2017/1", () {
      test("SELECTEDが2017/1なら", () {
        var viewModel = getViewModel(
            selectMonth: new DateTime(2017, 1, 1),
            pageMonth: new DateTime(2017, 1, 1),
            bookLogs: [new m.BookLog()..dateTime = new DateTime(2017, 1, 1)]);
        expect(
            viewModel.bookLogs.monthEnableds,
            equals([
              new v.MonthEnabled(2017, 1, true, true),
              new v.MonthEnabled(2017, 2, false, false),
              new v.MonthEnabled(2017, 3, false, false),
              new v.MonthEnabled(2017, 4, false, false),
              new v.MonthEnabled(2017, 5, false, false),
              new v.MonthEnabled(2017, 6, false, false),
              new v.MonthEnabled(2017, 7, false, false),
              new v.MonthEnabled(2017, 8, false, false),
              new v.MonthEnabled(2017, 9, false, false),
              new v.MonthEnabled(2017, 10, false, false),
              new v.MonthEnabled(2017, 11, false, false),
              new v.MonthEnabled(2017, 12, false, false),
            ]));
      });
      test("selectedが2017/2なら", () {
        var viewModel = getViewModel(
            selectMonth: new DateTime(2017, 2, 1),
            pageMonth: new DateTime(2017, 1, 1),
            bookLogs: [new m.BookLog()..dateTime = new DateTime(2017, 2, 1)]);
        expect(
            viewModel.bookLogs.monthEnableds,
            equals([
              new v.MonthEnabled(2017, 1, false, false),
              new v.MonthEnabled(2017, 2, true, true),
              new v.MonthEnabled(2017, 3, false, false),
              new v.MonthEnabled(2017, 4, false, false),
              new v.MonthEnabled(2017, 5, false, false),
              new v.MonthEnabled(2017, 6, false, false),
              new v.MonthEnabled(2017, 7, false, false),
              new v.MonthEnabled(2017, 8, false, false),
              new v.MonthEnabled(2017, 9, false, false),
              new v.MonthEnabled(2017, 10, false, false),
              new v.MonthEnabled(2017, 11, false, false),
              new v.MonthEnabled(2017, 12, false, false),
            ]));
      });
      test("selectedが2016/1なら", () {
        var viewModel = getViewModel(
            selectMonth: new DateTime(2016, 1, 1),
            pageMonth: new DateTime(2017, 1, 1),
            bookLogs: [new m.BookLog()..dateTime = new DateTime(2016, 2, 1)]);
        expect(
            viewModel.bookLogs.monthEnableds,
            equals([
              new v.MonthEnabled(2016, 1, false, false),
              new v.MonthEnabled(2016, 2, false, true),
              new v.MonthEnabled(2016, 3, false, false),
              new v.MonthEnabled(2016, 4, false, false),
              new v.MonthEnabled(2016, 5, false, false),
              new v.MonthEnabled(2016, 6, false, false),
              new v.MonthEnabled(2016, 7, false, false),
              new v.MonthEnabled(2016, 8, false, false),
              new v.MonthEnabled(2016, 9, false, false),
              new v.MonthEnabled(2016, 10, false, false),
              new v.MonthEnabled(2016, 11, false, false),
              new v.MonthEnabled(2016, 12, false, false),
            ]));
      });
    });
  });

  group("bookLogが", () {
    test("nullならisLoadingがtrue", () {
      var viewModel = getViewModel(
          selectMonth: new DateTime(2016, 1, 1),
          pageMonth: new DateTime(2017, 1, 1));
      expect(viewModel.bookLogs.isLoading, isTrue);
    });
    test("nullでないならisLoadingがfalse", () {
      var viewModel = getViewModel(
          selectMonth: new DateTime(2016, 1, 1),
          pageMonth: new DateTime(2017, 1, 1),
          bookLogs: []);
      expect(viewModel.bookLogs.isLoading, isFalse);
    });
  });

  group("bookLog", () {
    test("reviewがある", () {
      var viewModel = getViewModel(
          selectMonth: new DateTime(2017, 1, 1),
          pageMonth: new DateTime(2017, 1, 1),
          bookLogs: <m.BookLog>[
            new m.BookLog()
              ..dateTime = new DateTime(2017, 1, 1)
              ..title = "title1"
              ..author = "author1"
              ..image = "image1"
              ..review = "http://www.example.com"
              ..isRead = true
          ]);
      expect(viewModel.bookLogs.booklogs[0].hasReview, isTrue);
    });
    test("reviewがない", () {
      var viewModel = getViewModel(
          selectMonth: new DateTime(2017, 1, 1),
          pageMonth: new DateTime(2017, 1, 1),
          bookLogs: <m.BookLog>[
            new m.BookLog()
              ..dateTime = new DateTime(2017, 1, 1)
              ..title = "title1"
              ..author = "author1"
              ..image = "image1"
              ..review = ""
              ..isRead = true
          ]);
      expect(viewModel.bookLogs.booklogs[0].hasReview, isFalse);
    });
    test("読んだよしていない", () {
      var viewModel = getViewModel(
          selectMonth: new DateTime(2017, 1, 1),
          pageMonth: new DateTime(2017, 1, 1),
          bookLogs: <m.BookLog>[
            new m.BookLog()
              ..dateTime = new DateTime(2017, 1, 1)
              ..id = "id1"
              ..title = "title1"
              ..author = "author1"
              ..image = "image1"
              ..review = ""
              ..isRead = false
          ]);
      var attr = new BookAttrs("title1", "author1", "image1");
      expect(viewModel.bookLogs.booklogs[0],
          new v.BookLog("id1", attr, false, "", false, false));
    });
    test("読んだよセーブ中", () {
      var viewModel = getViewModel(
          selectMonth: new DateTime(2017, 1, 1),
          pageMonth: new DateTime(2017, 1, 1),
          bookLogs: <m.BookLog>[
            new m.BookLog()
              ..id = "id1"
              ..dateTime = new DateTime(2017, 1, 1)
              ..title = "title1"
              ..author = "author1"
              ..image = "image1"
              ..review = ""
              ..isRead = false
          ],
          saving : "id1");
      var attr = new BookAttrs("title1", "author1", "image1");
      expect(viewModel.bookLogs.booklogs[0],
          new v.BookLog("id1", attr, false, "", false, true));
    });
    test("読んだよ済", () {
      var viewModel = getViewModel(
          selectMonth: new DateTime(2017, 1, 1),
          pageMonth: new DateTime(2017, 1, 1),
          bookLogs: <m.BookLog>[
            new m.BookLog()
              ..id = "id1"
              ..dateTime = new DateTime(2017, 1, 1)
              ..title = "title1"
              ..author = "author1"
              ..image = "image1"
              ..review = ""
              ..isRead = true
          ]);
      var attr = new BookAttrs("title1", "author1", "image1");
      expect(viewModel.bookLogs.booklogs[0],
          new v.BookLog("id1", attr, false, "", true, false));
    });
    test("読んだよ解除中", () {
      var viewModel = getViewModel(
          selectMonth: new DateTime(2017, 1, 1),
          pageMonth: new DateTime(2017, 1, 1),
          bookLogs: <m.BookLog>[
            new m.BookLog()
              ..id = "id1"
              ..dateTime = new DateTime(2017, 1, 1)
              ..title = "title1"
              ..author = "author1"
              ..image = "image1"
              ..review = ""
              ..isRead = true
          ],
          saving : "id1");
      var attr = new BookAttrs("title1", "author1", "image1");
      expect(viewModel.bookLogs.booklogs[0],
          new v.BookLog("id1", attr, false, "", true, true));
    });

    test("ページが2017/1なら2016/12は表示されていない", () {
      var viewModel = getViewModel(
          selectMonth: new DateTime(2017, 1, 1),
          pageMonth: new DateTime(2017, 1, 1),
          bookLogs: <m.BookLog>[
            new m.BookLog()
              ..id = "id1"
              ..dateTime = new DateTime(2017, 1, 1)
              ..title = "title1"
              ..author = "author1"
              ..image = "image1"
              ..review = ""
              ..isRead = true,
            new m.BookLog()
              ..id = "id2"
              ..dateTime = new DateTime(2016, 12, 1)
              ..title = "title2"
              ..author = "author2"
              ..image = "image2"
              ..review = ""
              ..isRead = true,

          ]);
      var attr = new BookAttrs("title1", "author1", "image1");
      expect(viewModel.bookLogs.booklogs,
          [new v.BookLog("id1", attr, false, "", true, false)]);
    });
  });
}

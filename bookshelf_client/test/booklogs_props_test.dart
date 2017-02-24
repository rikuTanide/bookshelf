import 'package:bookshelf_client/model/booklogs.dart' as m;
import 'package:bookshelf_client/model/model.dart';
import 'package:bookshelf_client/props/props.dart';
import 'package:bookshelf_client/types/share.dart';
import 'package:bookshelf_client/types/view_model.dart';
import 'package:bookshelf_client/types/booklogs.dart' as v;
import 'package:test/test.dart';

ViewModel getViewModel(
    {DateTime now, DateTime pageMonth, DateTime selectMonth, List<
        m.BookLog> bookLogs}) {
  now = now ?? new DateTime.now();
  pageMonth = pageMonth ?? new DateTime.now();
  selectMonth = selectMonth ?? new DateTime.now();
  var model = new Model()
    ..bookLogs = (new m.BookLogs()
      ..pageMonth = pageMonth
      ..selectMonth = selectMonth
      ..booklogs = bookLogs)
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
        var viewModel = getViewModel(
            selectMonth: new DateTime(2017, 2, 1), bookLogs: []);
        expect(viewModel.bookLogs.yearSelectStates, equals([
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
            bookLogs: [
              new m.BookLog()
                ..dateTime = new DateTime(2017, 1, 1)
            ]);
        expect(viewModel.bookLogs.monthEnableds, equals([
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
            bookLogs: [
              new m.BookLog()
                ..dateTime = new DateTime(2017, 2, 1)
            ]);
        expect(viewModel.bookLogs.monthEnableds, equals([
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
            bookLogs: [
              new m.BookLog()
                ..dateTime = new DateTime(2016, 2, 1)
            ]);
        expect(viewModel.bookLogs.monthEnableds, equals([
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
    test("nullなら", () {});
    test("nullでないなら", () {});
  });

  group("bookLog", () {
    test("reviewがある", () {});
    test("reviewがない", () {});
    test("読んだよしていない", () {});
    test("読んだよセーブ中", () {});
    test("読んだよ済", () {});
    test("読んだよ解除中", () {});
    test("ページが2017/1なら2016/12は表示されていない", () {});
  });
}

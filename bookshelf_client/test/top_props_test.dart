import 'package:bookshelf_client/model/model.dart';
import 'package:bookshelf_client/model/top.dart' as m;
import 'package:bookshelf_client/props/props.dart';
import 'package:bookshelf_client/types/top.dart' as v;
import 'package:bookshelf_client/types/view_model.dart';
import "package:test/test.dart";

ViewModel getViewModel(
    {String username, DateTime now, List<m.BookLogger> bookLoggers}) {
  if (now == null) {
    now = new DateTime.now();
  }
  var top = new m.Top()
    ..bookLoggers = bookLoggers;
  return mapModelToViewModel(new Model()
    ..username = username
    ..now = now
    ..top = top);
}

void main() {
  group("top", () {
    test("model.topがnullでなければviewModel.topがnullでない", () {
      var viewModel = getViewModel();
      expect(viewModel.top, isNotNull);
    });
    test("username", () {
      var viewModel = getViewModel(username: "user1");
      expect(viewModel.top.headerLinkParams.username, equals("user1"));
    });
    test("nowが2017/2/1ならcurrent_yearは2", () {
      var viewModel = getViewModel(now: new DateTime(2017, 2, 1));
      expect(viewModel.top.headerLinkParams.current_year, equals(2017));
    });
    test("nowが2017/2/1ならcurrent_monthは１", () {
      var viewModel = getViewModel(now: new DateTime(2017, 2, 1));
      expect(viewModel.top.headerLinkParams.current_month, equals(2));
    });
    group("bookloggerが", () {
      test("nullならisLoading", () {
        var viewModel = getViewModel(bookLoggers: null);
        expect(viewModel.top.isLoading, equals(true));
      });
      test("nullでないならisLoadingがfalse", () {
        var viewModel = getViewModel(bookLoggers: []);
        expect(viewModel.top.isLoading, equals(false));
      });
      test("1個目", () {
        var viewModel = getViewModel(bookLoggers: [new m.BookLogger()
          ..username = "user1"
          ..year = 2017
          ..month = 2
        ]);
        expect(viewModel.top.bookLoggers,
            equals([new v.BookLogger("user1", 2017, 2)]));
      });
    });
  });
}
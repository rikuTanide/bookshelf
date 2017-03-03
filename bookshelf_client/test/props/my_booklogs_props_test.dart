import 'package:bookshelf_client/model/model.dart';
import 'package:bookshelf_client/model/my_booklogs.dart' as m;
import 'package:bookshelf_client/props/props.dart';
import 'package:bookshelf_client/types/my_booklogs.dart' as v;
import 'package:bookshelf_client/types/share.dart';
import 'package:bookshelf_client/types/view_model.dart';
import 'package:test/test.dart';

const EXAMPLE_COM = "https://www.example.com/";

ViewModel getViewModel({String username,
DateTime now,
DateTime pageMonth,
DateTime selectMonth,
List<m.BookLog> bookLogs,
m.Editing editing,
m.TitleSuggestions titleSuggestions,
m.AuthorSuggestions authorSuggestions}) {
  now = now ?? new DateTime.now();
  pageMonth = pageMonth ?? new DateTime.now();
  selectMonth = selectMonth ?? new DateTime.now();

  var myBookLogs = new m.MyBookLogs()
    ..selectMonth = selectMonth
    ..pageMonth = pageMonth
    ..bookLogs = bookLogs
    ..editing = editing
    ..titleSuggestions = titleSuggestions
    ..authorSuggestions = authorSuggestions;
  var model = new Model(username, "uid1", now, myBookLog: myBookLogs);
  return mapModelToViewModel(model);
}

void main() {
  group("myBookLog", () {
    test("nullでなければnullでない", () {
      var viewModel = getViewModel();
      expect(viewModel.myBookLogs, isNotNull);
    });
    test("usernameがuser1", () {
      var viewModel = getViewModel(username: "user1");
      expect(viewModel.myBookLogs.headerLinkParams.username, equals("user1"));
    });
    group("nowが2017/2/1なら", () {
      var viewModel = getViewModel(now: new DateTime(2017, 2, 1));
      test("current_yearは2017", () {
        expect(
            viewModel.myBookLogs.headerLinkParams.current_year, equals(2017));
      });
      test("current_monthは2", () {
        expect(viewModel.myBookLogs.headerLinkParams.current_month, equals(2));
      });
    });
    group("ページ選択ボタン", () {
      group("pageMonthが2017/1で", () {
        var pageMonth = new DateTime(2017, 1, 1);
        group("selectMonthが2017/1なら", () {
          var selectMonth = new DateTime(2017, 1, 1);
          var viewModel = getViewModel(
              pageMonth: pageMonth, selectMonth: selectMonth);
          test("2017年がselected", () {
            expect(viewModel.myBookLogs.yearSelectStates, equals([
              new YearSelectState(2014, false),
              new YearSelectState(2015, false),
              new YearSelectState(2016, false),
              new YearSelectState(2017, true),
            ]));
          });

          test("1月がactive", () {
            expect(viewModel.myBookLogs.monthEnableds, equals([
              new v.MonthEnabled(2017, 1, true),
              new v.MonthEnabled(2017, 2, false),
              new v.MonthEnabled(2017, 3, false),
              new v.MonthEnabled(2017, 4, false),
              new v.MonthEnabled(2017, 5, false),
              new v.MonthEnabled(2017, 6, false),
              new v.MonthEnabled(2017, 7, false),
              new v.MonthEnabled(2017, 8, false),
              new v.MonthEnabled(2017, 9, false),
              new v.MonthEnabled(2017, 10, false),
              new v.MonthEnabled(2017, 11, false),
              new v.MonthEnabled(2017, 12, false),
            ]));
          });
        });

        group("selectMonthが2017/2なら", () {
          var selectMonth = new DateTime(2017, 2, 1);
          var viewModel = getViewModel(
              pageMonth: pageMonth, selectMonth: selectMonth);
          test("2017年がselected", () {
            expect(viewModel.myBookLogs.yearSelectStates, equals([
              new YearSelectState(2014, false),
              new YearSelectState(2015, false),
              new YearSelectState(2016, false),
              new YearSelectState(2017, true),
            ]));
          });
          test("2月がactive", () {
            expect(viewModel.myBookLogs.monthEnableds, equals([
              new v.MonthEnabled(2017, 1, false),
              new v.MonthEnabled(2017, 2, true),
              new v.MonthEnabled(2017, 3, false),
              new v.MonthEnabled(2017, 4, false),
              new v.MonthEnabled(2017, 5, false),
              new v.MonthEnabled(2017, 6, false),
              new v.MonthEnabled(2017, 7, false),
              new v.MonthEnabled(2017, 8, false),
              new v.MonthEnabled(2017, 9, false),
              new v.MonthEnabled(2017, 10, false),
              new v.MonthEnabled(2017, 11, false),
              new v.MonthEnabled(2017, 12, false),
            ]));
          });
        });
        group("selectMonthが2016/1なら", () {
          var selectMonth = new DateTime(2016, 1, 1);
          var viewModel = getViewModel(
              pageMonth: pageMonth, selectMonth: selectMonth);
          test("2016年がselected", () {
            expect(viewModel.myBookLogs.yearSelectStates, equals([
              new YearSelectState(2014, false),
              new YearSelectState(2015, false),
              new YearSelectState(2016, true),
              new YearSelectState(2017, false),
            ]));
          });
          test("全部activeじゃな", () {
            expect(viewModel.myBookLogs.monthEnableds, equals([
              new v.MonthEnabled(2016, 1, false),
              new v.MonthEnabled(2016, 2, false),
              new v.MonthEnabled(2016, 3, false),
              new v.MonthEnabled(2016, 4, false),
              new v.MonthEnabled(2016, 5, false),
              new v.MonthEnabled(2016, 6, false),
              new v.MonthEnabled(2016, 7, false),
              new v.MonthEnabled(2016, 8, false),
              new v.MonthEnabled(2016, 9, false),
              new v.MonthEnabled(2016, 10, false),
              new v.MonthEnabled(2016, 11, false),
              new v.MonthEnabled(2016, 12, false),
            ]));
          });
        });
      });
    });

    //bookLog
    group("bookLogsが", () {
      test("nullならisLoading", () {
        var viewModel = getViewModel(bookLogs: null);
        expect(viewModel.myBookLogs.isLoading, equals(true));
      });
      test("nullでないならisLoadingはfalse", () {
        var viewModel = getViewModel(bookLogs: []);
        expect(viewModel.myBookLogs.isLoading, equals(false));
      });
    });
  });

  group("bookLogを", () {
    group("編集していない", () {
      test("レビューがある", () {
        var bookLog = new m.BookLog()
          ..id = "id1"
          ..title = "title1"
          ..author = "author1"
          ..image = "img.png"
          ..review = EXAMPLE_COM
          ..dateTime = new DateTime.now();
        var viewModel = getViewModel(bookLogs: [bookLog]);
        expect(viewModel.myBookLogs.bookLogs, equals([
          new v.BookLog(
              "id1",
              new BookAttrs("title1", "author1", "img.png"),
              new TitleSuggestions(false, false, []),
              new AuthorSuggestions(false, false, []),
              true,
              new v.EditReviewState(EXAMPLE_COM, true),
              new v.BookLogState(false, false, false, false, false)
          )
        ]));
      });
      test("レビューがない", () {
        var bookLog = new m.BookLog()
          ..id = "id1"
          ..title = "title1"
          ..author = "author1"
          ..image = "img.png"
          ..review = ""
          ..dateTime = new DateTime.now();
        var viewModel = getViewModel(bookLogs: [bookLog]);
        expect(viewModel.myBookLogs.bookLogs, equals([
          new v.BookLog(
              "id1",
              new BookAttrs("title1", "author1", "img.png"),
              new TitleSuggestions(false, false, []),
              new AuthorSuggestions(false, false, []),
              true,
              new v.EditReviewState("", true),
              new v.BookLogState(false, false, false, false, false)
          )
        ]));
      });
    });
    group("編集している", () {
      test("編集している行だけが編集状態になっている", () {
        var bookLog1 = new m.BookLog()
          ..id = "id1"
          ..title = "title1"
          ..author = "author1"
          ..image = "img.png"
          ..review = ""
          ..dateTime = new DateTime.now();
        var bookLog2 = new m.BookLog()
          ..id = "id2"
          ..title = "title2"
          ..author = "author2"
          ..image = "img.png"
          ..review = ""
          ..dateTime = new DateTime.now();
        var bookLog3 = new m.BookLog()
          ..id = "id3"
          ..title = "title3"
          ..author = "author3"
          ..image = "img.png"
          ..review = ""
          ..dateTime = new DateTime.now();

        var editing = new m.Editing()
          ..logID = "id2"
          ..title = "title2..."
          ..author = "author2..."
          ..image = "img.png..."
          ..review = EXAMPLE_COM + "..."
          ..isAdding = false
          ..isDeleting = false
          ..isSaving = false;
        var viewModel = getViewModel(
            editing: editing, bookLogs: [bookLog1, bookLog2, bookLog3]);
        expect(viewModel.myBookLogs.bookLogs, equals([
          new v.BookLog(
              "id1",
              new BookAttrs("title1", "author1", "img.png"),
              new TitleSuggestions(false, false, []),
              new AuthorSuggestions(false, false, []),
              true,
              new v.EditReviewState("", true),
              new v.BookLogState(false, false, false, false, false)
          ),
          new v.BookLog(
              "id2",
              new BookAttrs("title2...", "author2...", "img.png..."),
              new TitleSuggestions(false, false, []),
              new AuthorSuggestions(false, false, []),
              true,
              new v.EditReviewState(EXAMPLE_COM + "...", true),
              new v.BookLogState(true, false, true, false, false)
          ),
          new v.BookLog(
              "id3",
              new BookAttrs("title3", "author3", "img.png"),
              new TitleSuggestions(false, false, []),
              new AuthorSuggestions(false, false, []),
              true,
              new v.EditReviewState("", true),
              new v.BookLogState(false, false, false, false, false)
          ),

        ]));
      });
      test("削除中", () {
        var bookLog1 = new m.BookLog()
          ..id = "id1"
          ..title = "title1"
          ..author = "author1"
          ..image = "img.png"
          ..review = ""
          ..dateTime = new DateTime.now();
        var editing = new m.Editing()
          ..logID = "id1"
          ..title = "title1..."
          ..author = "author1..."
          ..image = "img.png..."
          ..review = EXAMPLE_COM + "..."
          ..isAdding = false
          ..isDeleting = true
          ..isSaving = false;

        var viewModel = getViewModel(
            editing: editing, bookLogs: [bookLog1]);
        expect(viewModel.myBookLogs.bookLogs, equals([
          new v.BookLog(
              "id1",
              new BookAttrs("title1...", "author1...", "img.png..."),
              new TitleSuggestions(false, false, []),
              new AuthorSuggestions(false, false, []),
              true,
              new v.EditReviewState(EXAMPLE_COM + "...", true),
              new v.BookLogState(true, true, true, false, true)
          ),
        ]));
      });
      test("保存中", () {
        var bookLog1 = new m.BookLog()
          ..id = "id1"
          ..title = "title1"
          ..author = "author1"
          ..image = "img.png"
          ..review = ""
          ..dateTime = new DateTime.now();
        var editing = new m.Editing()
          ..logID = "id1"
          ..title = "title1..."
          ..author = "author1..."
          ..image = "img.png..."
          ..review = EXAMPLE_COM + "..."
          ..isAdding = false
          ..isDeleting = false
          ..isSaving = true;

        var viewModel = getViewModel(
            editing: editing, bookLogs: [bookLog1]);
        expect(viewModel.myBookLogs.bookLogs, equals([
          new v.BookLog(
              "id1",
              new BookAttrs("title1...", "author1...", "img.png..."),
              new TitleSuggestions(false, false, []),
              new AuthorSuggestions(false, false, []),
              true,
              new v.EditReviewState(EXAMPLE_COM + "...", true),
              new v.BookLogState(true, true, true, true, false)
          ),
        ]));
      });
      test("タイトル候補ロード中", () {
        var bookLog1 = new m.BookLog()
          ..id = "id1"
          ..title = "title1"
          ..author = "author1"
          ..image = "img.png"
          ..review = ""
          ..dateTime = new DateTime.now();
        var editing = new m.Editing()
          ..logID = "id1"
          ..title = "title1..."
          ..author = "author1..."
          ..image = "img.png..."
          ..review = EXAMPLE_COM + "..."
          ..isAdding = false
          ..isDeleting = false
          ..isSaving = false;

        var viewModel = getViewModel(
            editing: editing, bookLogs: [bookLog1],
            titleSuggestions: new m.TitleSuggestions());
        expect(viewModel.myBookLogs.bookLogs, equals([
          new v.BookLog(
              "id1",
              new BookAttrs("title1...", "author1...", "img.png..."),
              new TitleSuggestions(true, true, []),
              new AuthorSuggestions(false, false, []),
              true,
              new v.EditReviewState(EXAMPLE_COM + "...", true),
              new v.BookLogState(true, false, true, false, false)
          ),
        ]));
      });
      test("タイトル候補表示中", () {
        var bookLog1 = new m.BookLog()
          ..id = "id1"
          ..title = "title1"
          ..author = "author1"
          ..image = "img.png"
          ..review = ""
          ..dateTime = new DateTime.now();
        var editing = new m.Editing()
          ..logID = "id1"
          ..title = "title1..."
          ..author = "author1..."
          ..image = "img.png..."
          ..review = EXAMPLE_COM + "..."
          ..isAdding = false
          ..isDeleting = false
          ..isSaving = false;

        var titleSuggestions = new m.TitleSuggestions();

        var viewModel = getViewModel(
            editing: editing,
            bookLogs: [bookLog1],
            titleSuggestions: titleSuggestions);
        expect(viewModel.myBookLogs.bookLogs, equals([
          new v.BookLog(
              "id1",
              new BookAttrs("title1...", "author1...", "img.png..."),
              new TitleSuggestions(
                  true, true, []),
              new AuthorSuggestions(false, false, []),
              true,
              new v.EditReviewState(EXAMPLE_COM + "...", true),
              new v.BookLogState(true, false, true, false, false)
          ),
        ]));
      });
      test("著者候補ロード中", () {
        var bookLog1 = new m.BookLog()
          ..id = "id1"
          ..title = "title1"
          ..author = "author1"
          ..image = "img.png"
          ..review = ""
          ..dateTime = new DateTime.now();
        var editing = new m.Editing()
          ..logID = "id1"
          ..title = "title1..."
          ..author = "author1..."
          ..image = "img.png..."
          ..review = EXAMPLE_COM + "..."
          ..isAdding = false
          ..isDeleting = false
          ..isSaving = false;

        var authorSuggestions = new m.AuthorSuggestions()
          ..authorSuggestionsResults = <m.AuthorSuggestion>[
            new m.AuthorSuggestion()
              ..author = "author-s1"
              ..image = "image-s1",
            new m.AuthorSuggestion()
              ..author = "author-s2"
              ..image = "image-s2",
            new m.AuthorSuggestion()
              ..author = "author-s3"
              ..image = "image-s3",
          ];

        var viewModel = getViewModel(
            editing: editing,
            bookLogs: [bookLog1],
            authorSuggestions: authorSuggestions);
        expect(viewModel.myBookLogs.bookLogs, equals([
          new v.BookLog(
              "id1",
              new BookAttrs("title1...", "author1...", "img.png..."),
              new TitleSuggestions(
                  false, false, []),
              new AuthorSuggestions(true, false, <AuthorSuggest>[
                new AuthorSuggest("author-s1", "image-s1"),
                new AuthorSuggest("author-s2", "image-s2"),
                new AuthorSuggest("author-s3", "image-s3"),
              ]),
              true,
              new v.EditReviewState(EXAMPLE_COM + "...", true),
              new v.BookLogState(true, false, true, false, false)
          ),
        ]));
      });
      test("著者候補表示中", () {
        var bookLog1 = new m.BookLog()
          ..id = "id1"
          ..title = "title1"
          ..author = "author1"
          ..image = "img.png"
          ..review = ""
          ..dateTime = new DateTime.now();
        var editing = new m.Editing()
          ..logID = "id1"
          ..title = "title1..."
          ..author = "author1..."
          ..image = "img.png..."
          ..review = EXAMPLE_COM + "..."
          ..isAdding = false
          ..isDeleting = false
          ..isSaving = false;

        var authorSuggestions = new m.AuthorSuggestions()
          ..authorSuggestionsResults = <m.AuthorSuggestion>[
            new m.AuthorSuggestion()
              ..author = "author-s1"
              ..image = "image-s1",
            new m.AuthorSuggestion()
              ..author = "author-s2"
              ..image = "image-s2",
            new m.AuthorSuggestion()
              ..author = "author-s3"
              ..image = "image-s3",
          ];

        var viewModel = getViewModel(
            editing: editing,
            bookLogs: [bookLog1],
            authorSuggestions: authorSuggestions);
        expect(viewModel.myBookLogs.bookLogs, equals([
          new v.BookLog(
              "id1",
              new BookAttrs("title1...", "author1...", "img.png..."),
              new TitleSuggestions(
                  false, false, []),
              new AuthorSuggestions(true, false, <AuthorSuggest>[
                new AuthorSuggest("author-s1", "image-s1"),
                new AuthorSuggest("author-s2", "image-s2"),
                new AuthorSuggest("author-s3", "image-s3"),
              ]),
              true,
              new v.EditReviewState(EXAMPLE_COM + "...", true),
              new v.BookLogState(true, false, true, false, false)
          ),
        ]));
      });
      test("レビューがinValid", () {
        var bookLog1 = new m.BookLog()
          ..id = "id1"
          ..title = "title1"
          ..author = "author1"
          ..image = "img.png"
          ..review = ""
          ..dateTime = new DateTime.now();
        var editing = new m.Editing()
          ..logID = "id1"
          ..title = "title1..."
          ..author = "author1..."
          ..image = "img.png..."
          ..review = "htp://www.example.com/"
          ..isAdding = false
          ..isDeleting = false
          ..isSaving = false;


        var viewModel = getViewModel(
            editing: editing,
            bookLogs: [bookLog1]);
        expect(viewModel.myBookLogs.bookLogs, equals([
          new v.BookLog(
              "id1",
              new BookAttrs("title1...", "author1...", "img.png..."),
              new TitleSuggestions(
                  false, false, []),
              new AuthorSuggestions(false, false, []),
              true,
              new v.EditReviewState("htp://www.example.com/", false),
              new v.BookLogState(true, false, false, false, false)
          ),
        ]));
      });
      test("レビューが空", () {
        var bookLog1 = new m.BookLog()
          ..id = "id1"
          ..title = "title1"
          ..author = "author1"
          ..image = "img.png"
          ..review = ""
          ..dateTime = new DateTime.now();
        var editing = new m.Editing()
          ..logID = "id1"
          ..title = "title1..."
          ..author = "author1..."
          ..image = "img.png..."
          ..review = ""
          ..isAdding = false
          ..isDeleting = false
          ..isSaving = false;


        var viewModel = getViewModel(
            editing: editing,
            bookLogs: [bookLog1]);
        expect(viewModel.myBookLogs.bookLogs, equals([
          new v.BookLog(
              "id1",
              new BookAttrs("title1...", "author1...", "img.png..."),
              new TitleSuggestions(
                  false, false, []),
              new AuthorSuggestions(false, false, []),
              true,
              new v.EditReviewState("", true),
              new v.BookLogState(true, false, true, false, false)
          ),
        ]));
      });
      test("タイトルが空", () {
        var bookLog1 = new m.BookLog()
          ..id = "id1"
          ..title = "title1"
          ..author = "author1"
          ..image = "img.png"
          ..review = ""
          ..dateTime = new DateTime.now();
        var editing = new m.Editing()
          ..logID = "id1"
          ..title = ""
          ..author = "author1..."
          ..image = "img.png..."
          ..review = ""
          ..isAdding = false
          ..isDeleting = false
          ..isSaving = false;


        var viewModel = getViewModel(
            editing: editing,
            bookLogs: [bookLog1]);
        expect(viewModel.myBookLogs.bookLogs, equals([
          new v.BookLog(
              "id1",
              new BookAttrs("", "author1...", "img.png..."),
              new TitleSuggestions(
                  false, false, []),
              new AuthorSuggestions(false, false, []),
              true,
              new v.EditReviewState("", true),
              new v.BookLogState(true, false, false, false, false)
          ),
        ]));
      });
      test("著者が空", () {
        var bookLog1 = new m.BookLog()
          ..id = "id1"
          ..title = "title1"
          ..author = "author1"
          ..image = "img.png"
          ..review = ""
          ..dateTime = new DateTime.now();
        var editing = new m.Editing()
          ..logID = "id1"
          ..title = "title1..."
          ..author = ""
          ..image = "img.png..."
          ..review = ""
          ..isAdding = false
          ..isDeleting = false
          ..isSaving = false;


        var viewModel = getViewModel(
            editing: editing,
            bookLogs: [bookLog1]);
        expect(viewModel.myBookLogs.bookLogs, equals([
          new v.BookLog(
              "id1",
              new BookAttrs("title1...", "", "img.png..."),
              new TitleSuggestions(
                  false, false, []),
              new AuthorSuggestions(false, false, []),
              true,
              new v.EditReviewState("", true),
              new v.BookLogState(true, false, false, false, false)
          ),
        ]));
      });
      test("著者とタイトルが空ではなくてレビューがvalidで保存中でも削除中でもなく候補を表示していない", () {
        var bookLog1 = new m.BookLog()
          ..id = "id1"
          ..title = "title1"
          ..author = "author1"
          ..image = "img.png"
          ..review = ""
          ..dateTime = new DateTime.now();
        var editing = new m.Editing()
          ..logID = "id1"
          ..title = "title1..."
          ..author = "author1..."
          ..image = "img.png..."
          ..review = EXAMPLE_COM
          ..isAdding = false
          ..isDeleting = false
          ..isSaving = false;


        var viewModel = getViewModel(
            editing: editing,
            bookLogs: [bookLog1]);
        expect(viewModel.myBookLogs.bookLogs, equals([
          new v.BookLog(
              "id1",
              new BookAttrs("title1...", "author1...", "img.png..."),
              new TitleSuggestions(
                  false, false, []),
              new AuthorSuggestions(false, false, []),
              true,
              new v.EditReviewState(EXAMPLE_COM, true),
              new v.BookLogState(true, false, true, false, false)
          ),
        ]));
      });
      test("追加中", () {
        var bookLog1 = new m.BookLog()
          ..id = "id1"
          ..title = "title1"
          ..author = "author1"
          ..image = "img.png"
          ..review = ""
          ..dateTime = new DateTime.now();
        var editing = new m.Editing()
          ..logID = null
          ..title = "title2..."
          ..author = "author2..."
          ..image = "img.png..."
          ..review = EXAMPLE_COM
          ..isAdding = true
          ..isDeleting = false
          ..isSaving = false;


        var viewModel = getViewModel(
            editing: editing,
            bookLogs: [bookLog1]);
        expect(viewModel.myBookLogs.bookLogs, equals([
          new v.BookLog(
              "id1",
              new BookAttrs("title1", "author1", "img.png"),
              new TitleSuggestions(
                  false, false, []),
              new AuthorSuggestions(false, false, []),
              true,
              new v.EditReviewState("", true),
              new v.BookLogState(false, false, false, false, false)
          ),
          new v.BookLog(
              null,
              new BookAttrs("title2...", "author2...", "img.png..."),
              new TitleSuggestions(
                  false, false, []),
              new AuthorSuggestions(false, false, []),
              true,
              new v.EditReviewState(EXAMPLE_COM, true),
              new v.BookLogState(true, false, true, false, false)
          ),
        ]));
      });

      test("pageMonthが2017/1なら2016/12のBookが表示されない", () {
        var bookLog1 = new m.BookLog()
          ..id = "id1"
          ..title = "title1"
          ..author = "author1"
          ..image = "img.png"
          ..review = ""
          ..dateTime = new DateTime(2017, 1, 1);
        var bookLog2 = new m.BookLog()
          ..id = "id2"
          ..title = "title2"
          ..author = "author2"
          ..image = "img.png"
          ..review = ""
          ..dateTime = new DateTime(2016, 12, 1);
        var viewModel = getViewModel(
            bookLogs: [bookLog1, bookLog2],
            pageMonth: new DateTime(2017, 1, 1));
        expect(viewModel.myBookLogs.bookLogs, equals([
          new v.BookLog(
              "id1",
              new BookAttrs("title1", "author1", "img.png"),
              new TitleSuggestions(
                  false, false, []),
              new AuthorSuggestions(false, false, []),
              true,
              new v.EditReviewState("", true),
              new v.BookLogState(false, false, false, false, false)
          )
        ]));
      });
    });
  }
  );
}

